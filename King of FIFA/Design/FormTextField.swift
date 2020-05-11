//
//  FormTextField.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/4/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

@IBDesignable
class FormTextField: UITextField {

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
