//
//  WBNewFetureView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBNewFetureView: UIView {

    /// 懒加载的属性
    lazy var scroolView: UIScrollView = {
        let scroolView = UIScrollView(frame: self.bounds)
        scroolView.showsVerticalScrollIndicator = false
        scroolView.showsHorizontalScrollIndicator = false
        scroolView.isPagingEnabled = true
        scroolView.bounces = false
        scroolView.delegate = self
        return scroolView
    }()
    
    /// 分页指示器
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = globalColor
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: screenBounds)
        //创建 UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

// MARK: - 创建 UI
extension WBNewFetureView {
    
    func setupUI() {
        //1. 添加子视图
        addSubview(scroolView)
        addSubview(pageControl)
        
        
        //2. 自动布局
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-100)
        }
        
        //3.添加新特性图片
        for i in 0..<4 {
            let imageView = UIImageView(imageName: "new_feature_\(i)")
            //offsetBy 偏移值
            imageView.frame = screenBounds.offsetBy(dx: CGFloat(i - 1)*screenWidh, dy: 0)
            scroolView.addSubview(imageView)
        }
    
        //设置 scrollView 的滚动大小
        scroolView.contentSize = CGSize(width: screenWidh*5, height: 0)
    }
}



// MARK: - scrollView的代理
extension WBNewFetureView: UIScrollViewDelegate {
    //监听 scrollView 的滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取 scrollView 的偏移值
        let offsetX = scroolView.contentOffset.x
        
        //计算当前页数
        let page = offsetX / screenWidh + 0.5
        
        pageControl.currentPage = Int(page)
        
        //隐藏pageControl
        pageControl.isHidden = offsetX > (screenWidh * 3.3)
        
        //将newFeature从页面移除
        if (offsetX >= screenWidh * 4) {
            self.removeFromSuperview()
        }
    }
    
}





