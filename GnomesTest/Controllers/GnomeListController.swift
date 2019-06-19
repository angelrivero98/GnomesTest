//
//  GnomeListController.swift
//  GnomesTest
//
//  Created by Romelys Rivero on 6/14/19.
//  Copyright © 2019 Angel Rivero. All rights reserved.
//

import UIKit

class GnomeListController: UITableViewController,UISearchBarDelegate {

    // MARK:- Variables Declarations
    var gnomes = [Gnome]()
    var filteredGnomes = [Gnome]()
    let searchController = UISearchController(searchResultsController: nil)
    let cellId = "cellId"
    
    // MARK: - View Inital Configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        setupTableView()
        fetchGnomes()
    }
    
    //MARK:- Setup Methods
    private func setUpSearchBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Brastlewark"
        searchController.searchBar.placeholder = "Search Gnomes"
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.white
        let texField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        texField?.tintColor = UIColor.white
    }
    
    /**
     Set up the table view with the cell design in the .xib file called "GnomeCell"
     */
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "GnomeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
    }
    
    /**
     Fetch gnomes from `APIService` and reload the gnomes table view data
     */
    private func fetchGnomes(){
        APIService.shared.fetchGnomes { (gnomes) in
            self.gnomes = gnomes
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Search Bar Methods
    
    /**
     Check if the search bar is empty
     
     - Returns: True if the text is empty or nil.
     */
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    /**
     Filter gnomes by name
     - Parameter searchText: Text introduced by the user to be search by
     */
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredGnomes = gnomes.filter({( gnome : Gnome) -> Bool in
            return gnome.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    /**
     Checks if the user is filtering gnomes
     
     - Returns: True if the search controller is active and the search bar isn't empty.
     */
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredGnomes = gnomes
        tableView.reloadData()
    }
    
    //MARK:- TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredGnomes.count
        }
        return gnomes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gnome: Gnome
        if isFiltering() {
            gnome = filteredGnomes[indexPath.row]
        } else {
            gnome = gnomes[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GnomeCell
        cell.gnome = gnome
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gnome: Gnome
        let gnomeDetailsController = GnomeDetailsController(nibName: "GnomeDetailsController", bundle: nil)
        if isFiltering() {
            gnome = filteredGnomes[indexPath.row]
        } else {
            gnome = gnomes[indexPath.row]
        }
        gnomeDetailsController.gnome = gnome
        self.navigationController?.pushViewController(gnomeDetailsController, animated: true)
    }
    
}

extension GnomeListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

}
