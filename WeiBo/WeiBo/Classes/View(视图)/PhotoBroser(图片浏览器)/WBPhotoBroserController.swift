//
//  WBPhotoBroserController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/8.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBPhotoBroserController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellow
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    

}
