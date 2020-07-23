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
            //вариант чтения из даты одинаковых элементов по кругу
            var tempPrjsonDataHZ = [Datum]()
            var tempPrjsonDataSelector = [Datum]()
            var tempPrjsonDataPicture = [Datum]()
            if prjsonData.filter({ $0.name == "hz" }).count != 0 {
                tempPrjsonDataHZ = prjsonData.filter({ $0.name == "hz" })
            }
            if prjsonData.filter({ $0.name == "selector" }).count != 0 {
                tempPrjsonDataSelector = prjsonData.filter({ $0.name == "selector" })
            }
            if prjsonData.filter({ $0.name == "picture" }).count != 0 {
                tempPrjsonDataPicture = prjsonData.filter({ $0.name == "picture" })
            }
            let prjsonView = prjson.view
            
            if prjsonView.count != 0 && prjsonData.count != 0 {
                for i in 0...prjsonView.count - 1 {
                    switch prjsonView[i] {
                    case "hz":
                        if tempPrjsonDataHZ.count != 0 {
                        self.tableArray.append(HzItemStruct(hzText: tempPrjsonDataHZ[0].data.text!))
                            tempPrjsonDataHZ.remove(at: 0)
                            if tempPrjsonDataHZ.count == 0 {
                                tempPrjsonDataHZ = prjsonData.filter({ $0.name == "hz" })
                            }
                        }
                    case "selector":
                        if tempPrjsonDataSelector.count != 0 {
                        self.tableArray.append(SelectorItemStruct(selectedId: tempPrjsonDataSelector[0].data.selectedID!, variants: tempPrjsonDataSelector[0].data.variants!))
                            tempPrjsonDataSelector.remove(at: 0)
                            if tempPrjsonDataSelector.count == 0 {
                                tempPrjsonDataSelector = prjsonData.filter({ $0.name == "selector" })
                            }
                        }
                    case "picture":
                        if tempPrjsonDataPicture.count != 0 {
                        self.tableArray.append(PictureItemStruct(pictureUrl: tempPrjsonDataPicture[0].data.url!, namePicture: tempPrjsonDataPicture[0].data.text!))
                            tempPrjsonDataPicture.remove(at: 0)
                            if tempPrjsonDataPicture.count == 0 {
                                tempPrjsonDataPicture = prjsonData.filter({ $0.name == "picture" })
                            }
                        }
                        //так как думал что это неизменяемый набор видов "name" (их только эти три), на default поставил последний третий вариант
                    //default: self.tableArray.append(PictureItemStruct(pictureUrl: prjsonData.filter({ $0.name == "picture" })[0].data.url!, namePicture: prjsonData.filter({ $0.name == "picture" })[0].data.text!))
                    default: continue
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
