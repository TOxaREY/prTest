//
//  HzTableViewCell.swift
//  prTest
//
//  Created by REYNIKOV ANTON on 14.07.2020.
//  Copyright © 2020 REYNIKOV ANTON. All rights reserved.
//

import UIKit


class HzTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hzLabel: UILabel!
    
    var item: NameTypeProtocol? {
        didSet {
            guard let item = item as? HzItemStruct else {
                return
            }
            hzLabel?.text = item.hzText
        }
    }
}
