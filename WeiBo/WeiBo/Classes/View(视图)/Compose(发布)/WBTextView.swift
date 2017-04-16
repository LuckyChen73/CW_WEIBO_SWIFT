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


// MARK: - 插入表情
extension WBTextView {
    /// 插入表情
    func insertEmotion(emotion: WBEmotionModel) {
        //如果是 emoji 表情
        if emotion.type == 1 {
            //把十六进制数转换成表情字符串
            let emotion = NSString.emoji(withStringCode: emotion.code!)
            //插入字符串
            self.insertText(emotion!)
            
        }else {
            //1.创建一个不可变的表情的富文本
            
            //用表情去创建一个富文本的附件
            let attachMent = NSTextAttachment()
            //给富文本的附件设置图片
            attachMent.image = UIImage(named: emotion.fullPngPath!)
            //给附件设置大小和位置
             attachMent.bounds = CGRect(x: 0, y: -3, width: self.font!.lineHeight, height: self.font!.lineHeight)
            //使用附件创建不可变的富文本
            let attachmentString = NSAttributedString(attachment: attachMent)
            
            
            //2.通过不可变的富文本创建一个可变的表情的富文本
            let mattachmentString = NSMutableAttributedString(attributedString: attachmentString)
            //给表情富文本添加属性
            mattachmentString.addAttributes([NSFontAttributeName: self.font!], range: NSMakeRange(0, mattachmentString.length))
            
            
            //3. 获取当前的 textView 的富文本的副本
            let attributedString = self.attributedText.copy() as! NSAttributedString
            //用 textView 的富文本生成一个可变的富文本
            let mattributedString = NSMutableAttributedString(attributedString: attributedString)
            
            
            //4. 取到光标的位置
            var range = self.selectedRange
            
            
            //5. 向富文本中插入一个表情文本
            mattributedString.replaceCharacters(in: range, with: attachmentString)
            
            
            //6. 插入完成之后，将光标往后移动一个长度
            range.location += 1
            range.length = 0
            
            
            //7. 给 textView 的富文本设置文本属性
            mattributedString.addAttributes([NSFontAttributeName: self.font!], range: NSMakeRange(0, mattributedString.length))
            
            
            //8. 设置 attributeText 的属性值
            self.attributedText = mattributedString
            
            
            //9. 重新定位光标
            self.selectedRange = range
        }
        
        //手动发通知
        let notification = Notification(name: Notification.Name.UITextViewTextDidChange)
        NotificationCenter.default.post(notification)
        
        //手动调用代理
        self.delegate?.textViewDidChange!(self)
        
    }

}















