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

    //测试数据数组
    var dataSourceArr = WBEmotionTool.shared.dataSourceArr
    
    /// 表情的collectionView
    lazy var emotionView: UICollectionView = {
        //创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmotionLayout())
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        
        collectionView.register(WBEmotionCell.self, forCellWithReuseIdentifier: identifier)
        
        return collectionView
    }()
    
    /// pageControl 分页指示器
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        
        pageControl.isEnabled = false
        //默认显示4页
        pageControl.numberOfPages = self.dataSourceArr[0].count
        
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
        //分页指示器跟着连动
        setupPageControl(indexPath: indexPath)
    }
    
}

// MARK: - 监听手动拖拽emotionView滚动的代理 UICollectionViewDelegate
extension WBCustomKeyboard: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.拿到两个 cells
        let cells = emotionView.visibleCells
        //2.获取 cell在屏幕显示的区域
        if cells.count > 1 {
            let cell1 = cells[0]
            let cell2 = cells[1]
            
            //判断 offset与 cell 的 originX 的差值的绝对值的大小，绝对值越小，显示区域越大
            let offset = scrollView.contentOffset.x
            let originX1 = cell1.frame.origin.x
            let originX2 = cell2.frame.origin.x
            
//            print("offset:  \(offset)")
//            print("originX1:\(originX1)")
//            print("originX2:\(originX2)")
//            print("================================")

            let origin1 = abs(offset - originX1)
            let origin2 = abs(offset - originX2)
          
            if origin1 < origin2 {
                //取到 cell1所在的下标路径
                let indexPath1 = emotionView.indexPath(for: cell1)
                toolBar.selectedIndex = (indexPath1?.section)!
                setupPageControl(indexPath: indexPath1!)
                
            }else {
                let indexPath2 = emotionView.indexPath(for: cell2)
                toolBar.selectedIndex = (indexPath2?.section)!
                setupPageControl(indexPath: indexPath2!)
            }
        }
    }
}


// MARK: - UI 搭建
extension WBCustomKeyboard {
    func setupUI() {
        addSubview(emotionView)
        addSubview(pageControl)
        addSubview(toolBar)
        
        emotionView.backgroundColor = UIColor.rgbColor(r: 243, g: 243, b: 243)
        
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
    
    
    /// 创建分页指示器
    func setupPageControl(indexPath: IndexPath) {
        pageControl.numberOfPages = dataSourceArr[indexPath.section].count
        pageControl.currentPage = indexPath.item
    }
    
    
}


// MARK: - 数据源方法
extension WBCustomKeyboard: UICollectionViewDataSource {
    //多少组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSourceArr.count //这里返回4个大组
    }
    //每组多少 item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArr[section].count // 返回每个大组里的小组的个数
    }
    //具体 item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! WBEmotionCell
        //先通过组取，再通过item取，得到一维模型数组
        cell.emotions = dataSourceArr[indexPath.section][indexPath.item]
        
        return cell
    }
    
    
}



