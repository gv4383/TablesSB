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
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        devices = fetchDevices()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceCell
        let device = devices[indexPath.row]
        
        cell.set(device: device)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = devices[indexPath.row]
        
        guard let destinationVC = storyboard?.instantiateViewController(
            identifier: "DeviceDetailsViewController",
            creator: { coder in
                DeviceDetailsViewController(device: device, coder: coder)
            }
        ) else {
            fatalError("Failed to create Device Details VC")
        }
        destinationVC.loadViewIfNeeded()
        destinationVC.set(device: device)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
