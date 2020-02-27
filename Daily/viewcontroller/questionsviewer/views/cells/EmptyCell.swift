//
//  EmptyCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 25.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class EmptyCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
