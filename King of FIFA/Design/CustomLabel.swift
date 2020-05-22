//
//  CustomLabel.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/18/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
        
    }

}
