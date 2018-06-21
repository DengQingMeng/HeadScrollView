//
//  ViewController.swift
//  HeadScrollView
//
//  Created by AndyDeng on 2018/6/21.
//  Copyright © 2018年 AndyDeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 20, y: 20, width: 100, height: 100)
        button.backgroundColor = UIColor.yellow
        button.addTarget(self, action: #selector(ViewController.buttonPressed), for: .touchUpInside)
        button.setTitle("click", for: .normal)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func buttonPressed() {
        let mainViewController = MainViewController()
        let nav = UINavigationController.init(rootViewController: mainViewController)
        self.present(nav, animated: true) {
            
        }
        
        
    }
}

