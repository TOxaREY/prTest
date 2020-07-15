//
//  SelectTableViewCell.swift
//  prTest
//
//  Created by REYNIKOV ANTON on 14.07.2020.
//  Copyright © 2020 REYNIKOV ANTON. All rights reserved.
//

import UIKit


class SelectTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var selectPickerView: UIPickerView!
    
    var pickerArray = [Variant]()
    var selectedIdStart = true
    var selectedID = Int()
    
    var item: NameTypeProtocol? {
        didSet {
            guard let item = item as? SelectorItemStruct else {
                return
            }
            pickerArray = item.variants
            if selectedIdStart {
                selectedID = item.selectedId
                selectedIdStart = false
            }
            selectPickerView?.dataSource = self
            selectPickerView?.delegate = self
            DispatchQueue.main.async {
                self.selectPickerView?.selectRow(self.selectedID, inComponent: 0, animated: true)
                self.selectPickerView?.reloadAllComponents()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.font = UIFont.systemFont(ofSize: 25)
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.text = pickerArray[row].text
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedID = row
        NotificationCenter.default.post(name: Notification.Name("selectedPicker"), object: nil, userInfo: ["selector":row])
    }
}
