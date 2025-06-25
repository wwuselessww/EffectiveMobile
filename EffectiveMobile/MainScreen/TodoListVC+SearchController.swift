//
//  TodoListVC+SearchController.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import UIKit


extension TodoListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        presenter?.searchTodo(with: query)
    }
    
    internal func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
    }
    
    

}
