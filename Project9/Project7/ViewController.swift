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
                DispatchQueue.main.async { [weak self] in
                    self?.navigationItem.leftBarButtonItem?.style = .done
                    self?.navigationItem.leftBarButtonItem?.title = "Filtered"
                    self?.tableView.reloadData()
                    self?.setTitle("\(self?.petitions.count ?? 0) petitions found")
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.navigationItem.leftBarButtonItem?.style = .plain
                    self?.navigationItem.leftBarButtonItem?.title = "Filter"
                }
                fetchJSON()
                setTitle()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(handleCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(handleFilter))

        performSelector(inBackground: #selector(fetchJSON), with: nil)
        setTitle()
    }
    
    func setTitle(_ toTitle: String = "WhiteHouse Petitions") {
        self.title = toTitle
    }
    
    @objc func fetchJSON() {
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
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func handleFilter() {

        if navigationItem.leftBarButtonItem?.style == .plain {
            let ac = UIAlertController(title: "Filter Petitions", message: nil, preferredStyle: .alert)
            ac.addTextField(configurationHandler: nil)
            
            let submitAction = UIAlertAction(title: "Filter", style: .default) { [weak self, weak ac] _ in
                guard let filter = ac?.textFields?[0].text else { return }
                if filter.isEmpty {
                    return
                } else {
                    DispatchQueue.global(qos: .background).async {
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
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
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
