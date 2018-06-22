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
    var count: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "网易新闻"
        
        // HeadView
        let headArray = ["头条","娱乐","体育","财经","科技","NBA","手机", "数码", "汽车", "时尚", "电影", "游戏", "房产"]
        count = headArray.count
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
            newsViewController.dispalyString = headArray[i]
            self.addChildViewController(newsViewController)
            newsViewController.view.frame = CGRect.init(x: CGFloat(i)*self.view.bounds.size.width, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height-108)
            bgScrollView.addSubview(newsViewController.view)
        }
    }
    
    @objc func itemButtonPressed(sender: UIButton) {
        let tag = sender.tag - 1000
        //        bgScrollView.scrollRectToVisible(CGRect.init(x: CGFloat(tag)*self.view.bounds.size.width, y: 108, width: self.view.bounds.size.width, height: self.view.bounds.size.height-108), animated: false)
        //        bgScrollView.setContentOffset(CGPoint.init(x: CGFloat(tag)*self.view.bounds.size.width, y: 0), animated: false)
        // 用这个方法能使 scrollViewDidScroll 不触发
        bgScrollView.bounds.origin = CGPoint(x: CGFloat(tag)*self.view.bounds.size.width, y: 0)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.indicateView.frame = CGRect.init(x: Gap + (Gap + ItemWidth)*CGFloat(tag), y: 42, width: ItemWidth, height: 2)
        }) { (finish) in

        }
        self.headItemCoverDisplayAnimation(tag: sender.tag)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
//        print(offset)
        self.indicateView.frame = CGRect.init(x: Gap + (offset/self.view.frame.size.width)*(Gap + ItemWidth), y: 42, width: ItemWidth, height: 2)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.view.frame.size.width
        let currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1
        print(currentPage)
        let tag = Int(currentPage) + 1000
        self.headItemCoverDisplayAnimation(tag: tag)
    }
    
    func headItemCoverDisplayAnimation(tag: Int) {
        let itemButton = headScrollView.viewWithTag(tag)
        let relativeRect = itemButton?.convert(headScrollView.frame, to: self.view)
        
        //        let orginX: CGFloat = Gap + CGFloat(tag)*(Gap + ItemWidth)
        let orginX: CGFloat = relativeRect!.origin.x
        let width: CGFloat = Gap + ItemWidth
        // 往右点
        if orginX + width + width > self.view.frame.size.width {
            if itemButton!.frame.origin.x + width + width - self.view.frame.size.width > (Gap + CGFloat(count)*Gap+CGFloat(count)*ItemWidth - self.view.frame.size.width) {
                headScrollView.setContentOffset(CGPoint.init(x: Gap + CGFloat(count)*Gap+CGFloat(count)*ItemWidth - self.view.frame.size.width, y: 0), animated: true)
            }
            else {
                headScrollView.setContentOffset(CGPoint.init(x: itemButton!.frame.origin.x + width + width - self.view.frame.size.width, y: 0), animated: true)
            }
        }
        else if orginX - width < 0 {
            // 往左点
            if headScrollView.contentOffset.x+orginX-width-Gap < 0 {
                headScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            }
            else {
                headScrollView.setContentOffset(CGPoint.init(x: headScrollView.contentOffset.x+orginX-width-Gap, y: 0), animated: true)
            }
        }
    }
    
}
