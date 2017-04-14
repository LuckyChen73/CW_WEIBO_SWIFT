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
    lazy var toolBar: WBKeyboardToolbar = {
        let toolBar = WBKeyboardToolbar()
        toolBar.delegate = self
        return toolBar
    }()
    
    //测试数据数组
    var dataSourceArr = [[1, 2, 3], [1, 2], [1, 2, 3, 4], [1, 2]]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 底部键盘工具条代理 WBKeyboardToolbarDelegate
extension WBCustomKeyboard: WBKeyboardToolbarDelegate {
    /// 实现代理方法
    func toggleKeyboard(section: Int) {
        //先取到要移动到的 item 的下标路径
        let indexPath = IndexPath(item: 0, section: section)
        //滚动到对应路径的item
        emotionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        
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
    //多少组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSourceArr.count
    }
    //每组多少 item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArr[section].count
    }
    //具体 item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        
        //在创建 lab 之前先将之前的创建的 lab 对应的 view 移除，这样就可以防止 cell 的重用
        cell.contentView.viewWithTag(55)?.removeFromSuperview()
        let lable = UILabel(title: "section:\(indexPath.section), item:\(indexPath.item)", fontSize: 40, alignment: .center)
        lable.sizeToFit()
        lable.tag = 55
        lable.center = cell.contentView.center
        cell.contentView.addSubview(lable)
        
        return cell
    }
    
    
}



