//
//  MainViewController.swift
//  HeadScrollView
//
//  Created by AndyDeng on 2018/6/21.
//  Copyright © 2018年 AndyDeng. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    var currentController: UIViewController!
    var newsViewController: NewsViewController!
    var bgScrollView: UIScrollView!
    var headScrollView: UIScrollView!
    var indicateView: UIView!
    var isScroll = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "网易新闻"
        
        // HeadView
        let headArray = ["头条","娱乐","体育","财经","科技","NBA","手机", "数码"]
        let count = headArray.count
        headScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.bounds.size.width, height: 44))
        headScrollView.contentSize = CGSize.init(width: Gap + CGFloat(count)*Gap+CGFloat(count)*ItemWidth, height: 44)
        headScrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(headScrollView)
        for i in 0 ..< headArray.count {
            let item = headArray[i]
            let itemButton = UIButton.init(type: .custom)
            itemButton.frame = CGRect.init(x: Gap + CGFloat(i)*Gap + CGFloat(i)*ItemWidth, y: 0, width: ItemWidth, height: 40)
            itemButton.setTitle(item, for: .normal)
            itemButton.backgroundColor = UIColor.lightGray
            itemButton.layer.cornerRadius = 6
            itemButton.tag = i + 1000
            itemButton.addTarget(self, action: #selector(MainViewController.itemButtonPressed(sender:)), for: .touchUpInside)
            headScrollView.addSubview(itemButton)
        }
        
        indicateView = UIView.init(frame: CGRect.init(x: Gap, y: 42, width: ItemWidth, height: 2))
        indicateView.backgroundColor = UIColor.blue
        headScrollView.addSubview(indicateView)
        
        bgScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 108, width: self.view.bounds.size.width, height: self.view.bounds.size.height-108))
        bgScrollView.backgroundColor = UIColor.clear
        bgScrollView.isPagingEnabled = true
        bgScrollView.contentSize = CGSize.init(width: CGFloat(count)*self.view.bounds.size.width, height: self.view.bounds.size.height-108)
        bgScrollView.delegate = self
        self.view.addSubview(bgScrollView)
        
        for i in 0 ..< headArray.count {
            let newsViewController = NewsViewController()
            newsViewController.index = i
            
            self.addChildViewController(newsViewController)
            newsViewController.view.frame = CGRect.init(x: CGFloat(i)*self.view.bounds.size.width, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height-108)
            bgScrollView.addSubview(newsViewController.view)
        }
        
    }
    //    @objc func buttonPressed() {
    //        self.addChildViewController(self.secondViewController)
    //        self.transition(from: firstViewController, to: secondViewController, duration: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: {
    //
    //        }) { (finished) in
    //            self.secondViewController.didMove(toParentViewController: self)
    //            self.firstViewController.willMove(toParentViewController: nil)
    //            self.firstViewController.removeFromParentViewController()
    //            self.currentController = self.secondViewController
    //            print(self.childViewControllers)
    //
    //        }
    //
    //    }
    
    @objc func itemButtonPressed(sender: UIButton) {
        isScroll = false
        let tag = sender.tag - 1000
        bgScrollView.scrollRectToVisible(CGRect.init(x: CGFloat(tag)*self.view.bounds.size.width, y: 108, width: self.view.bounds.size.width, height: self.view.bounds.size.height-108), animated: false)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.indicateView.frame = CGRect.init(x: Gap + (Gap + ItemWidth)*CGFloat(tag), y: 42, width: ItemWidth, height: 2)
        }) { (finish) in
            self.isScroll = true
        }
        
        let orginX: CGFloat = Gap + CGFloat(tag)*(Gap + ItemWidth)
        let width: CGFloat = Gap + ItemWidth
        if orginX + width + width > self.view.frame.size.width {
            headScrollView.setContentOffset(CGPoint.init(x: orginX + width + width - self.view.frame.size.width, y: 0), animated: true)
        }
        else if orginX - width < 0 {
            headScrollView.setContentOffset(CGPoint.init(x: orginX-width, y: 0), animated: true)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isScroll {
            let offset = scrollView.contentOffset.x
            print(offset)
            self.indicateView.frame = CGRect.init(x: Gap + (offset/self.view.frame.size.width)*(Gap + ItemWidth), y: 42, width: ItemWidth, height: 2)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    //    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    //
    //    }
    
}
