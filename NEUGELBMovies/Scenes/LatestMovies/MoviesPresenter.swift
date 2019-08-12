//
//  MoviesPresenter.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol MoviesView: AnyObject {
    func refreshMoviesView()
    func displayMoviesRetrievalError(title: String, message: String)
    func refreshAutoCompleteData()
    func refreshSearchMoviesView()
}

protocol MovieCellView {
    func configure(with viewModel: MovieCellViewModel)
}

protocol MoviesPresenter {
    var numberOfMovies: Int { get }
    var autoCompleteSearchData: [String] { get }
    var router: MoviesViewRouter { get }
    
    func viewDidLoad()
    func configure(cell: MovieCellView, forRow row: Int)
    func didSelect(row: Int)
    func searchAbout(movieTitle: String)
    func loadAutoCompleteText(movieTitle: String)
    func endSearch()
    func loadMoreMovies()
}

class MoviesPresenterImplementation: MoviesPresenter {
    private weak var view: MoviesView?
    private let displayMoviesUseCase: DisplayLatestMoviesUseCase
    private let searchAboutMovieUseCase: SearchAboutMovieUseCase
    internal let router: MoviesViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var movies = [Movie]()
    var searchResultMovies = [Movie]()
    var autoCompleteSearchSource = [String]()
    
    private var discoverCurrentPage = 1
    private var searchCurrentPage = 1
    private var isSearching = false
    private var searchText = ""
    
    var numberOfMovies: Int {
        if isSearching {
            return searchResultMovies.count
        } else {
            return movies.count
        }
    }
    
    var autoCompleteSearchData: [String] {
        return autoCompleteSearchSource
    }
    
    init(view: MoviesView,
         displayMoviesUseCase: DisplayLatestMoviesUseCase,
         searchAboutMovieUseCase: SearchAboutMovieUseCase,
         router: MoviesViewRouter) {
        self.view = view
        self.displayMoviesUseCase = displayMoviesUseCase
        self.searchAboutMovieUseCase = searchAboutMovieUseCase
        self.router = router
    }
    
    // MARK: - MoviesPresenter
    
    func viewDidLoad() {
        self.loadLatestMovies()
    }
    
    func loadMoreMovies() {
        if isSearching {
            searchAbout(movieTitle: searchText)
        } else {
            loadLatestMovies()
        }
    }
    
    func configure(cell: MovieCellView, forRow row: Int) {
        var movie: Movie!
        if isSearching {
            movie = searchResultMovies[row]
        } else {
            movie = movies[row]
        }
        let viewModel = MovieCellViewModel(title: movie.title!, year: 2019, rate: movie.voteCount!, moviePoster: movie.posterPath ?? "")
        
        cell.configure(with: viewModel)
    }
    
    func didSelect(row: Int) {
        if isSearching {
            let movie = searchResultMovies[row]
            router.presentDetailsView(for: movie)
        } else {
            let movie = movies[row]
            router.presentDetailsView(for: movie)
        }
    }
    
    func searchAbout(movieTitle: String) {
        self.searchText = movieTitle
        self.searchAboutMovieUseCase.searchAboutMovie(with: movieTitle, at: searchCurrentPage) { (result: Result<[Movie], Error>) in
            switch result {
            case let .success(movies):
                self.handleSearchMoviesReceived(movies)
            case let .failure(error):
                self.handleMoviesError(error)
            }
        }
    }
    
    func loadAutoCompleteText(movieTitle: String) {
        self.isSearching = true
        self.searchAboutMovieUseCase.searchAboutMovie(with: movieTitle, at: 1) { (result: Result<[Movie], Error>) in
            switch result {
            case let .success(movies):
                self.handleLoadAutoCompleteText(movies)
            case .failure:
                break
            }
        }
    }
    
    func endSearch() {
        self.isSearching = false
        self.searchResultMovies.removeAll()
        self.movies.removeAll()
        self.autoCompleteSearchSource.removeAll()
        self.discoverCurrentPage = 1
        self.searchCurrentPage = 1
        loadLatestMovies()
    }
    
    // MARK: - Private Funcitons
    
    private func loadLatestMovies() {
        self.displayMoviesUseCase.displayLatestMovies(at: discoverCurrentPage) { (result: Result<[Movie], Error>) in
            switch result {
            case let .success(movies):
                self.handleMoviesReceived(movies)
            case let .failure(error):
                self.handleMoviesError(error)
            }
        }
    }
    
    private func handleLoadAutoCompleteText(_ movies: [Movie]) {
        self.autoCompleteSearchSource = movies.map({ movie -> String in
            return movie.title ?? ""
        })
        view?.refreshAutoCompleteData()
    }
    
    private func handleSearchMoviesReceived(_ movies: [Movie]) {
        if !movies.isEmpty {
            self.searchCurrentPage += 1
            self.searchResultMovies.append(contentsOf: movies)
            self.view?.refreshSearchMoviesView()
        }
    }
    
    private func handleMoviesReceived(_ movies: [Movie]) {
        if !movies.isEmpty {
            self.discoverCurrentPage += 1
            self.movies.append(contentsOf: movies)
            self.view?.refreshMoviesView()
        }
    }
    
    private func handleMoviesError(_ error: Error) {
        self.view?.displayMoviesRetrievalError(title: "Error", message: error.localizedDescription)
    }
    
}
