//
//  DeviceCell.swift
//  TablesSB
//
//  Created by Goyo Vargas on 8/14/22.
//

import UIKit

class DeviceCell: UITableViewCell {
    @IBOutlet weak var deviceLabel: UILabel!
    
    func set(device: Device) {
        deviceLabel.text = device.name
    }
}
