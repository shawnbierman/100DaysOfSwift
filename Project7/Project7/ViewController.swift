//
//  ViewController.swift
//  Project7
//
//  Created by Shawn Bierman on 3/5/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var filterIsOn = false {
        didSet {
            if filterIsOn {
                navigationItem.leftBarButtonItem?.style = .done
                navigationItem.leftBarButtonItem?.title = "Filtered"
                tableView.reloadData()
                setTitle("\(petitions.count) petitions found")
            } else {
                navigationItem.leftBarButtonItem?.style = .plain
                navigationItem.leftBarButtonItem?.title = "Filter"
                getData()
                setTitle()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(handleCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(handleFilter))

        getData()
        setTitle()
    }
    
    func setTitle(_ toTitle: String = "WhiteHouse Petitions") {
        self.title = toTitle
    }
    
    func getData() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    @objc func handleFilter() {

        if navigationItem.leftBarButtonItem?.style == .plain {
            let ac = UIAlertController(title: "Filter Petitions", message: nil, preferredStyle: .alert)
            ac.addTextField(configurationHandler: nil)
//            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            let submitAction = UIAlertAction(title: "Filter", style: .default) { [weak self, weak ac] _ in
                guard let filter = ac?.textFields?[0].text else { return }
                if filter.isEmpty {
                    return
                } else {
                    self?.filteredPetitions.removeAll(keepingCapacity: true)
                    self?.petitions.forEach({ [weak self] petition in
                        if petition.body.localizedCaseInsensitiveContains(filter) {
                            self?.filteredPetitions.append(petition)
                        }
                    })
                    self?.petitions = (self?.filteredPetitions)!
                    self?.filterIsOn = true
                }
            }
            
            ac.addAction(submitAction)
            present(ac, animated: true)
        } else {
            filterIsOn = false
        }
    }

    @objc func handleCredits() {
        let ac = UIAlertController(title: "Credits", message: "This data courtesy of the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//
//Challenge
//One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:
//
// 1. Add a Credits button to the top-right corner using UIBarButtonItem. When this is tapped, show an alert telling users the data comes from the We The People API of the Whitehouse.
// 2. Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered. Use a UIAlertController with a text field to let them enter that string. This is a tough one, so I’ve included some hints below if you get stuck.
// 3. Experiment with the HTML – this isn’t a HTML or CSS tutorial, but you can find lots of resources online to give you enough knowledge to tinker with the layout a little.
