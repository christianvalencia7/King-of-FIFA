//
//  CustomNavigationBar.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/11/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

   @IBInspectable var backColor: UIColor? {
        didSet {
            layer.backgroundColor = backColor?.cgColor
        }
    }

//    @IBInspectable var height: CGFloat = 0 {
//        didSet {
//            layer. = height
//        }
//    }
}
