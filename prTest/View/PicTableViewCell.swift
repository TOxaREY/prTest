//
//  PicTableViewCell.swift
//  prTest
//
//  Created by REYNIKOV ANTON on 14.07.2020.
//  Copyright © 2020 REYNIKOV ANTON. All rights reserved.
//

import UIKit



class PicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var picLabel: UILabel!
    
    var picUrlStart = true
    var picUrl = String()
    
    var item: NameTypeProtocol? {
        didSet {
            guard let item = item as? PictureItemStruct else {
                return
            }
            picLabel?.text = item.namePicture
            picUrl = item.pictureUrl
        }
    }
    
    func load(url: String, tableView: UITableView, index: IndexPath) {
        if picUrlStart {
            picUrlStart = false
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: URL(string: url)!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.picImageView?.image = image
                            tableView.beginUpdates()
                            tableView.reloadRows(at: [index], with: .none)
                            tableView.endUpdates()
                        }
                    }
                }
            }
        }
    }
}
