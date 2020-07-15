//
//  ViewModel.swift
//  prTest
//
//  Created by REYNIKOV ANTON on 14.07.2020.
//  Copyright © 2020 REYNIKOV ANTON. All rights reserved.
//

import UIKit


class ViewModel {
    
    var netMan = NetMan()
    var tableArray = [NameTypeProtocol]()
    
    func request(tableView: UITableView, vc: UIViewController) {
        netMan.request { (prjson) in
            let prjsonData = prjson.data
            let prjsonView = prjson.view
            
            if prjsonView.count != 0 && prjsonData.count != 0 {
                for i in 0...prjsonView.count - 1 {
                    switch prjsonView[i] {
                    case "hz": self.tableArray.append(HzItemStruct(hzText: prjsonData.filter({ $0.name == "hz" })[0].data.text!))
                    case "selector": self.tableArray.append(SelectorItemStruct(selectedId: prjsonData.filter({ $0.name == "selector" })[0].data.selectedID!, variants: prjsonData.filter({ $0.name == "selector" })[0].data.variants!))
                    default: self.tableArray.append(PictureItemStruct(pictureUrl: prjsonData.filter({ $0.name == "picture" })[0].data.url!, namePicture: prjsonData.filter({ $0.name == "picture" })[0].data.text!))
                    }
                }
            } else {
                return
            }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func numberOfRows() -> Int {
        return tableArray.count
    }
    
    func cellForRowAt(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableArray[indexPath.row]
        switch item.name {
        case "hz":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "hzCell") as? HzTableViewCell {
                cell.item = item
                return cell
            }
        case "picture":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "picCell") as? PicTableViewCell {
                cell.item = item
                cell.load(url: cell.picUrl, tableView: tableView, index: indexPath)
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "selectCell") as? SelectTableViewCell {
                cell.item = item
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func changeLabel(label: UILabel, indexPath: IndexPath) {
        label.text = "Name: \(tableArray[indexPath.row].name)"
    }
    
    func changeLabelPicker(label: UILabel, notification: Notification) {
        if let id = notification.userInfo?["selector"] as? Int {
            label.text = "Name: selector, ID: \(id)"
        }
    }
    
    func heightForRowAt(heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableArray[indexPath.row].name == "selector" {
            return 125.0
        } else {
            return UITableView.automaticDimension
        }
    }
}
