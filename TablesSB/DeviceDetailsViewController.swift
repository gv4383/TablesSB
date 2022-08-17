//
//  DeviceDetailsViewController.swift
//  TablesSB
//
//  Created by Goyo Vargas on 8/15/22.
//

import UIKit

class DeviceDetailsViewController: UIViewController {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var device: Device!
    
    init?(device: Device, coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = device
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }
    
    func set(device: Device) {
        categoryLabel.text = "Category - \(device.category)"
        descriptionLabel.text = device.description
    }
    
    private func configureVC() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        title = device.name
    }
}
