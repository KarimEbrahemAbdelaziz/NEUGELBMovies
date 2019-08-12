//
//  MoviesViewController.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import UIKit
import ModernSearchBar

class MoviesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var moviesTableView: UITableView!
    @IBOutlet private weak var searchBar: ModernSearchBar!
    
    // MARK: - Properties
    
    var configurator = MoviesConfiguratorImplementation()
    var presenter: MoviesPresenter!
    
    private var isFetchingMore = false
    private var isLoadingAutoComplete = false
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(moviesViewController: self)
        configureTableView()
        configureSearchBar()
        setGradientBackground()
        
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - Private Functions
    
    private func configureTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchBar.delegateModernSearchBar = self
        searchBar.suggestionsView_maxHeight = 200
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
    }
    
    private func setGradientBackground() {
        let bottomColor =  UIColor.pinkCustom.cgColor
        let topColor = UIColor.yellowCustom.cgColor
        
        self.setGradientBackground(topColor: topColor, bottomColor: bottomColor)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !isFetchingMore {
                isFetchingMore = true
                presenter.loadMoreMovies()
            }
        }
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        presenter.endSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !isLoadingAutoComplete {
            isLoadingAutoComplete = true
            presenter.loadAutoCompleteText(movieTitle: searchText)
        }
        
        if searchText.isEmpty {
            presenter.endSearch()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        presenter.searchAbout(movieTitle: searchText)
    }
}

// MARK: - UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

// MARK: - ModernSearchBarDelegate

extension MoviesViewController: ModernSearchBarDelegate {
    func onClickItemSuggestionsView(item: String) {
        searchBar.endEditing(true)
        searchBar.text = item
        presenter.searchAbout(movieTitle: item)
    }
}

// MARK: - MoviesView

extension MoviesViewController: MoviesView {
    func refreshMoviesView() {
        isFetchingMore = false
        moviesTableView.reloadData()
    }
    
    func displayMoviesRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
    
    func refreshAutoCompleteData() {
        self.isLoadingAutoComplete = false
        self.searchBar.setDatas(datas: presenter.autoCompleteSearchData)
        self.searchBar.getSuggestionsView().reloadData()
        self.searchBar.layoutIfNeeded()
    }
}
