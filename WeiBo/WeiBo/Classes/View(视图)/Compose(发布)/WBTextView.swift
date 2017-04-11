//
//  WBTextView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/11.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBTextView: UITextView {

    
    var placeHolder: String = "请输入微博......" {
        didSet{
            plabel.text = "请输入微博......";
        }
    }
    
    override var font: UIFont? {
        didSet{
            plabel.font = font
        }
    }
    
    /// 占位符
    fileprivate lazy var plabel: UILabel = {
        let label = UILabel(title: nil, titleColor: UIColor.lightGray, fontSize: 14)
        label.font = self.font
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
        
        self.font = UIFont.systemFont(ofSize: 14)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
        //下拉和键盘回弹
        self.alwaysBounceVertical = true
        self.keyboardDismissMode = .onDrag
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


// MARK: - 通知代理做法
extension WBTextView {
    
    /// 文本发生变动
    func textDidChange() {
        //隐藏占位符
        plabel.isHidden = self.text.characters.count > 0
        
    }
    
    
}




// MARK: - 搭建 UI
extension WBTextView {
    
    func setupUI() {
        addSubview(plabel)
        
        //scrollView的自动布局的问题, 默认情况下, right和bottom代表的是contentSize的width和height; 在一开始的时, 需要创建一个和scrollView一样的大小的view, 将scrollView撑开
        let view = UIView()
        insertSubview(view, at: 0)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self) //相当于同时设top,right, bottom, left
            make.width.equalTo(self)
            make.height.equalTo(self)
        }
        
        //占位label, 调整点位label的布局,让其与textView的文字对齐
        plabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
        }
        
    }
    
    
    
}


















