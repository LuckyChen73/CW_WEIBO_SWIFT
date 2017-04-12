//
//  WBCustomKeyboard.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/12.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

fileprivate let identifier = "emotion"

class WBCustomKeyboard: UIView {

    /// 表情的collectionView
    lazy var emotionView: UICollectionView = {
        //设置layout
        let layout = UICollectionViewFlowLayout()
        let cellWH = (screenWidh - 40)/3
        layout.itemSize = CGSize(width: cellWH, height: cellWH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        //创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        return collectionView
    }()
    
    /// pageControl 分页指示器
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
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
            make.height.equalTo(150)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(emotionView.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.left.right.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(36)
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



