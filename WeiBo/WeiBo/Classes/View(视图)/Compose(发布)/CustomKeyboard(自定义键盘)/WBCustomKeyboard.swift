//
//  WBCustomKeyboard.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/12.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

fileprivate let identifier = "emotion"


/// UICollectionViewFlowLayoutl类
fileprivate class EmotionLayout: UICollectionViewFlowLayout
{
    override func prepare() {
        super.prepare()
        //设置layout
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        itemSize = CGSize(width: screenWidh, height: 150)
        scrollDirection = .horizontal
    }

}

class WBCustomKeyboard: UIView {

    /// 表情的collectionView
    lazy var emotionView: UICollectionView = {
        //创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmotionLayout())
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        return collectionView
    }()
    
    /// pageControl 分页指示器
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.setValue(UIImage(named: "compose_keyboard_dot_normal"), forKey: "_pageImage")//默认的小图片
        pageControl.setValue(UIImage(named: "compose_keyboard_dot_selected"), forKey: "_currentPageImage") // 选中的图片
        
        return pageControl
    }()
    
    /// 底部的toolBar
    lazy var toolBar: WBKeyboardToolbar = WBKeyboardToolbar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI 搭建
extension WBCustomKeyboard {
    
    func setupUI() {
        addSubview(emotionView)
        addSubview(pageControl)
        addSubview(toolBar)
        
        emotionView.backgroundColor = UIColor.yellow
        pageControl.backgroundColor = UIColor.green
        toolBar.backgroundColor = UIColor.blue
        
        emotionView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(160)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(emotionView.snp.bottom)
            make.height.equalTo(19)
            make.left.right.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(37)
        }

        
    }
    
    
}


// MARK: - 数据源方法
extension WBCustomKeyboard: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    
}



