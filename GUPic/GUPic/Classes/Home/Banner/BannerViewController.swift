//
//  BannerViewController.swift
//  GUPic
//
//  Created by Recluse on 2017/7/4.
//  Copyright © 2017年 Recluse. All rights reserved.
//

import UIKit

protocol BannerViewControllerDelegaate {
    func bannerDataSource() -> [String]
    func bannerViewSize() -> CGSize
}

class BannerViewController: UIViewController, UIScrollViewDelegate {
    
    var delegate: BannerViewControllerDelegaate!
    let screenWidth = UIScreen.main.bounds.size.width
    
    var currentIndex: Int = 0   //当前索引
    var dataSource: [String]?
    
    var leftImageView, middleImageView, rightImageView: UIImageView?
    var scrollView: UIScrollView?
    
    var scrollViewWidth: CGFloat?
    var scrollViewHeight: CGFloat?
    
    var pageControl: UIPageControl?
    var placeholderImage: UIImage!
    
    var autoScrollTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size: CGSize = self.delegate.bannerViewSize()
        self.scrollViewWidth = size.width
        self.scrollViewHeight = size.height
        print(size.width,size.height)
        
        self.dataSource = self.delegate.bannerDataSource()
        
        self.setupScrollView()
        self.setupPlaceholder()
        self.setupImageView()
        self.setupPageControl()
        self.setupAutoScrollTimer()
        
        self.view.backgroundColor = UIColor.black
        

    }
    
    func setupScrollView() {
        self.scrollView = UIScrollView(frame: CGRect(x: 0,y: 0, width: self.scrollViewWidth!, height: self.scrollViewHeight!))
        self.scrollView?.backgroundColor = UIColor.red
        self.scrollView?.delegate = self
        self.scrollView?.contentSize = CGSize(width: self.scrollViewWidth! * 3, height: self.scrollViewHeight!)
        //滚动视图内容区域向左偏移一个view的宽度
        self.scrollView?.contentOffset = CGPoint(x: self.scrollViewWidth!, y: 0)
        self.scrollView?.isPagingEnabled = true
        self.scrollView?.bounces = false
        self.view.addSubview(self.scrollView!)
    }
    
    func setupPlaceholder() {
        var font: UIFont?
        if #available(iOS 8.2, *) {
            font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightMedium)
        } else {
            font = UIFont.systemFont(ofSize: 17.0)
            
        }
        let size = CGSize(width: self.scrollViewWidth!, height: self.scrollViewHeight!)
        placeholderImage = UIImage(text: "图片加载中...", font: font!, color:UIColor.white, size:size)
    }

    func setupImageView() {
        self.leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.scrollViewWidth!, height: self.scrollViewHeight!))
        self.middleImageView = UIImageView(frame: CGRect(x: self.scrollViewWidth!, y: 0, width: self.scrollViewWidth!, height: self.scrollViewHeight! ));
        self.rightImageView = UIImageView(frame: CGRect(x: 2 * self.scrollViewWidth!, y: 0, width: self.scrollViewWidth!, height: self.scrollViewHeight!));
        self.scrollView?.showsHorizontalScrollIndicator = false
        
        //设置初始时左中右三个imageView的图片（分别时数据源中最后一张，第一张，第二张图片）
        if(self.dataSource?.count != 0){
            resetImageViewSource()
        }
        
        self.scrollView?.addSubview(self.leftImageView!)
        self.scrollView?.addSubview(self.middleImageView!)
        self.scrollView?.addSubview(self.rightImageView!)
    }
    
    func setupPageControl() {
        self.pageControl = UIPageControl(frame: CGRect(x: screenWidth/2 - 60, y: self.scrollViewHeight! - 20, width: 120, height: 20))
        self.pageControl?.numberOfPages = (self.dataSource?.count)!
        self.pageControl?.isUserInteractionEnabled = false
        self.view.addSubview(self.pageControl!)
    }
    
    func setupAutoScrollTimer() {
        self.autoScrollTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(BannerViewController.letItScroll), userInfo: nil, repeats: true)
    }
    
    func letItScroll() {
        let offset = CGPoint(x: 2 * scrollViewWidth!, y: 0)
        self.scrollView?.setContentOffset(offset, animated: true)
    }
    
    func resetImageViewSource() {
        //当前显示的是第一张图片
        if self.currentIndex == 0 {
            self.leftImageView?.imageFromURL(self.dataSource!.last!,
                                             placeholder: placeholderImage)
            self.middleImageView?.imageFromURL(self.dataSource!.first!,
                                               placeholder: placeholderImage)
            let rightImageIndex = (self.dataSource?.count)!>1 ? 1 : 0 //保护
            self.rightImageView?.imageFromURL(self.dataSource![rightImageIndex],
                                              placeholder: placeholderImage)
        }
            //当前显示的是最后一张图片
        else if self.currentIndex == (self.dataSource?.count)! - 1 {
            self.leftImageView?.imageFromURL(self.dataSource![self.currentIndex-1],
                                             placeholder: placeholderImage)
            self.middleImageView?.imageFromURL(self.dataSource!.last!,
                                               placeholder: placeholderImage)
            self.rightImageView?.imageFromURL(self.dataSource!.first!,
                                              placeholder: placeholderImage)
        }
            //其他情况
        else{
            self.leftImageView?.imageFromURL(self.dataSource![self.currentIndex-1],
                                             placeholder: placeholderImage)
            self.middleImageView?.imageFromURL(self.dataSource![self.currentIndex],
                                               placeholder: placeholderImage)
            self.rightImageView?.imageFromURL(self.dataSource![self.currentIndex+1],
                                              placeholder: placeholderImage)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        
        if(self.dataSource?.count != 0){
            
            //如果向左滑动（显示下一张）
            if(offset >= self.scrollViewWidth!*2){
                //还原偏移量
                scrollView.contentOffset = CGPoint(x: self.scrollViewWidth!, y: 0)
                //视图索引+1
                self.currentIndex = self.currentIndex + 1
                
                if self.currentIndex == self.dataSource?.count {
                    self.currentIndex = 0
                }
            }
            
            //如果向右滑动（显示上一张）
            if(offset <= 0){
                //还原偏移量
                scrollView.contentOffset = CGPoint(x: self.scrollViewWidth!, y: 0)
                //视图索引-1
                self.currentIndex = self.currentIndex - 1
                
                if self.currentIndex == -1 {
                    self.currentIndex = (self.dataSource?.count)! - 1
                }
            }
            
            //重新设置各个imageView的图片
            resetImageViewSource()
            //设置页控制器当前页码
            self.pageControl?.currentPage = self.currentIndex
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        autoScrollTimer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setupAutoScrollTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
