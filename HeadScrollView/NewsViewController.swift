//
//  NewsViewController.swift
//  HeadScrollView
//
//  Created by AndyDeng on 2018/6/21.
//  Copyright © 2018年 AndyDeng. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 10, y: 70, width: 50, height: 50)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(NewsViewController.buttonPressed), for: .touchUpInside)
        button.setTitle("\(index)", for: .normal)
        self.view.addSubview(button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("frist")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonPressed() {
        let dd = DetailViewController()
        self.navigationController?.pushViewController(dd, animated: true)
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
