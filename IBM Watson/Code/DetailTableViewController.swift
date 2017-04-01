//
//  DetailTableViewController.swift
//  IBM Watson
//
//  Created by Kalyan Vishnubhatla on 3/31/17.
//  Copyright © 2017 Kalyan Vishnubhatla. All rights reserved.
//

import UIKit
import YelpAPI

class DetailTableViewController: UITableViewController {
    
    var business : YLPBusiness!
    var reviews : [YLPReview] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = self.business.name
        
        self.tableView.register(UINib(nibName: "ReviewCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.client.reviewsForBusiness(withId: self.business.identifier, completionHandler: { (search, error) in
            guard search != nil else {
                return
            }
            
            self.reviews = search!.reviews
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReviewCellTableViewCell
        
        let review = self.reviews[indexPath.row]
        cell.reviewText.text = review.excerpt
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let review = self.reviews[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "reviews") as! ReviewViewController
        controller.review = review
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}
