//
//  ViewController.swift
//  IBM Watson
//
//  Created by Kalyan Vishnubhatla on 3/31/17.
//  Copyright © 2017 Kalyan Vishnubhatla. All rights reserved.
//

import UIKit
import YelpAPI

class ViewController: UITableViewController, UISearchBarDelegate {

    var results = Array<YLPBusiness>()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.setShowsCancelButton(false, animated: true)
        self.searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = self.searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Search bar delegate
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let text = searchBar.text
        if text != nil && text!.characters.count > 0 {
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.client.search(withLocation: text!, completionHandler: { (search, error) in
                if search == nil || search?.businesses.count == 0 {
                    return
                }
                
                self.results = search!.businesses
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    // UITableView Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let business = self.results[indexPath.row]
        cell.textLabel?.text = business.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
    }
}

