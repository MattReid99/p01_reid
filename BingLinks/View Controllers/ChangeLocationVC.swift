//
//  ChangeLocationVC.swift
//  BingLinks
//
//  Created by Matthew Reid on 4/16/18.
//  Copyright © 2018 Matthew Reid. All rights reserved.
//

import UIKit
import Firebase

class ChangeLocationVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // IBOutlets
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // this array is updated every time the query changes, it displays a truncated list of filtered locations
    var filteredData = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // allows this View Controller to govern the tableView's properties
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.titleView = searchField
        searchField.showsScopeBar = false // you can show/hide this dependant on your layout
        searchField.placeholder = "Search by Location"
        searchField.delegate = self
        
        
        
        definesPresentationContext = true
        
        // make the screen support swipe to go back functionality
        self.view.isUserInteractionEnabled = true
        let swipe = UIPanGestureRecognizer.init(target: self, action: #selector(backPressed))
        self.view.addGestureRecognizer(swipe)
    }
    
    
    // go back to previous screen
    @objc @IBAction func backPressed(_sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // if location is selected, leave this screen and save the user's preference to settings
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selection = filteredData[indexPath.row]
        
        let defaults = UserDefaults.standard
        
        // set the selected string to be the user's location
        if let indexOf = Locations.cityNames.index(where: { $0 == "\(selection)" }) { 
            defaults.set(true, forKey: "customLocation")
            let temp = Locations.counties[indexOf].replacingOccurrences(of: "\"", with: "")
            defaults.set(temp, forKey: "location")
            
            self.dismiss(animated: true, completion: nil)
        }
    }
 
    // filter data whenever the text changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = Locations.cityNames.filter({( str : String) -> Bool in
            return str.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    // return up to 20 entries
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if 20 < filteredData.count {
                return 20
            }
            return filteredData.count
    }
    
    // filter data, remove endline at end of string
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let str: String
        
        str = filteredData[indexPath.row].replacingOccurrences(of: "\"", with: "")

        cell.textLabel?.text = str
        
        return cell
    }
}
