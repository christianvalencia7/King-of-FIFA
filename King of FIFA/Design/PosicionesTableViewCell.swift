//
//  PosicionesTableViewCell.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/19/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class PosicionesTableViewCell: UITableViewCell {

    @IBOutlet weak var posLabel: CustomLabel!
    @IBOutlet weak var nombreLabel: CustomLabel!
    @IBOutlet weak var golLabel: CustomLabel!
    @IBOutlet weak var puntosLabel: CustomLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
