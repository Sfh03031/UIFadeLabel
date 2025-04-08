//
//  ViewController.swift
//  UIFadeLabel
//
//  Created by Sfh03031 on 04/08/2025.
//  Copyright (c) 2025 Sfh03031. All rights reserved.
//

import UIKit
import UIFadeLabel

class ViewController: UIViewController {
    
    var i = 0
    var list = [
        "为众人抱薪者，不可使其冻毙于风雪；\n为自由开拓者，不可使其困顿于荆棘；\n为生民立命者，不可使其陨殁于无声。",
        "It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.\nA lady’s imagination is very rapid; it jumps from admiration to love, from love to matrimony in a moment.\nHappiness in this world, when it comes, comes incidentally. Make it the object of pursuit, and it leads us a wild-goose chase, and is never attained.",
        "我哭，我笑，但不抱怨\n我羞，我愧，但不悲叹\n我怒，我恨，但不自弃\n我是鹰——云中有志\n我是马——背上有鞍\n我是骨——骨中有钙\n我是汗——汗中有盐\n我要对着蓝天说，我是青年。\n祖国啊\n既然你因残缺太多\n把我们划入了青年的梯队\n我们就有青年和中年双重的肩\n",
        "He was an old man who fished alone in a skiff in the Gulf Stream and he had gone eighty-four days now without taking a fish.\nAll happy families are alike; each unhappy family is unhappy in its own way.\nAll children, except one, grow up. That one remains a child. It is Peter Pan."
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(fadeLabel)
        fadeLabel.text = list[i]
    }
    
    @objc func tap() {
        i += 1
        fadeLabel.text = list[i % list.count]
    }
    
    lazy var fadeLabel: UIFadeLabel = {
        let label = UIFadeLabel()
        label.frame = CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height)
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.isFadeNeeded = true
        label.appearDuration = 1
        label.disappearDuration = 1
        label.textColor = UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0 , green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        return label
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

