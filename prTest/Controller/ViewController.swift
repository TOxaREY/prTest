//
//  ViewController.swift
//  prTest
//
//  Created by REYNIKOV ANTON on 14.07.2020.
//  Copyright © 2020 REYNIKOV ANTON. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel = ViewModel()
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @objc func statusLabelPicker(notification: Notification) {
        viewModel.changeLabelPicker(label: statusLabel, notification: notification)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.request(tableView: tableView, vc: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.statusLabelPicker(notification:)), name: Notification.Name("selectedPicker"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.cellForRowAt(tableView: tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.changeLabel(label: statusLabel, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(heightForRowAt: indexPath)
    }
    
}


