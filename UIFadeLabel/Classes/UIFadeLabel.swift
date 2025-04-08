//
//  UIFadeLabel.swift
//  UIFadeLabel_Example
//
//  Created by sfh on 2024/11/19.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

public class UIFadeLabel: UILabel {
    
    // fade in duration
    @IBInspectable public var appearDuration: CFTimeInterval = 1.0
    // fade out duration
    @IBInspectable public var disappearDuration: CFTimeInterval = 1.0
    // need fade or not
    @IBInspectable public var isFadeNeeded = true
    
    private var attributedString = NSMutableAttributedString()
    private var displaylink: CADisplayLink?
    private var isAppearing: Bool = false
    private var isDisappearing: Bool = false
    private var isChangingText: Bool = false
    private var beginTime: CFTimeInterval?
    private var endTime: CFTimeInterval?
    private var durationArray: [CFTimeInterval] = []
    private var tempValue: String = ""
    private var textColorAlpha: CGFloat = 1
    
    public override var text: String? {
        get {
            return isFadeNeeded ? self.attributedString.string : super.text
        }
        set {
            if isFadeNeeded {
                self.toAttributedString(text: newValue ?? "")
            } else {
                super.text = newValue
            }
        }
    }
    
    public override var textColor: UIColor! {
        didSet {
            if self.textColor.cgColor.alpha > 0 {
                textColorAlpha = self.textColor.cgColor.alpha
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        displaylink = CADisplayLink.init(target: self, selector: #selector(update))
        displaylink?.isPaused = true
        displaylink?.add(to: .current, forMode: .commonModes)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 更新富文本效果
    @objc func update() {
        let pastDuration = CACurrentMediaTime() - beginTime!
        if isAppearing {
            if pastDuration > appearDuration {
                displaylink?.isPaused = true
                isAppearing = false
            }
            for i in 0..<self.attributedString.length  {
                var progress:CGFloat = CGFloat((pastDuration - durationArray[i]) / (appearDuration * 0.5))
                if progress > 1 { progress = 1 }
                if progress < 0 { progress = 0 }
                let color = self.textColor.withAlphaComponent(progress * textColorAlpha)
                attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: i, length: 1))
            }
        }
        if isDisappearing {
            if pastDuration > disappearDuration {
                displaylink?.isPaused = true
                isDisappearing = false
                if isChangingText {
                    isChangingText = false
                    self.appear()
                }
                return
            }
            for i in 0..<self.attributedString.length {
                var progress:CGFloat = CGFloat((pastDuration - durationArray[i]) / (disappearDuration * 0.5))
                if progress > 1 { progress = 1 }
                if progress < 0 { progress = 0 }
                let color = self.textColor.withAlphaComponent((1 - progress) * textColorAlpha)
                attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: i, length: 1))
            }
        }
        attributedText = attributedString
    }
    
}

extension UIFadeLabel {
    
    /// 开始计算
    func toAttributedString(text: String) {
        tempValue = text
        if self.attributedText != nil {
            if self.attributedText!.length > 0 {
                disappear()
                isChangingText = true
            } else {
                appear()
            }
        } else {
            appear()
        }
    }
    
    /// 渐现
    func appear() {
        attributedString = NSMutableAttributedString.init(string: tempValue)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        attributedString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: tempValue.count))
        
        isAppearing = true
        beginTime = CACurrentMediaTime()
        endTime = CACurrentMediaTime() + appearDuration
        displaylink?.isPaused = false
        
        calculateDuration(duration: appearDuration)
    }
    
    /// 渐隐
    func disappear() {
        isDisappearing = true
        beginTime = CACurrentMediaTime()
        endTime = CACurrentMediaTime() + disappearDuration
        displaylink?.isPaused = false
        calculateDuration(duration: disappearDuration)
    }
    
    /// 计算渐隐渐现的随机时间点
    func calculateDuration(duration: Double) {
        durationArray = []
        for _ in 0..<self.attributedString.length {
            let progress: CGFloat = CGFloat(arc4random_uniform(100)) / 100.0
            let duration: CFTimeInterval = progress * CGFloat(duration) * 0.5
            durationArray.append(duration)
        }
    }
}
