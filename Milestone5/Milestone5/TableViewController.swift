//
//  TableViewController.swift
//  Milestone5
//
//  Created by Shawn Bierman on 4/14/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var countries = [Country]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        Service.shared.fetchCountries { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                self.countries = success
            }
        }
    }
}

extension TableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int                                { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int    { return countries.count }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let country = countries[indexPath.row]
        
        cell.textLabel?.text = country.name
        
        return cell
    }
}
