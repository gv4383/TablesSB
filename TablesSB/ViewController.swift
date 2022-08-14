//
//  ViewController.swift
//  TablesSB
//
//  Created by Goyo Vargas on 8/14/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var devices = [Device]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        devices = fetchDevices()
    }
    
    private func fetchDevices() -> [Device] {
        let path = Bundle.main.path(forResource: "iot_devices", ofType: "json")
        
        guard let path = path else {
            print("Error: bad file path")
            
            return []
        }
        
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            if let deviceData = try? decoder.decode([Device].self, from: data) {
                return deviceData
            } else {
                print("Error: something went wrong parsing device data")
                
                return []
            }
        } catch {
            print("Error: there was a problem fetch devices")
            
            return []
        }
    }
}
