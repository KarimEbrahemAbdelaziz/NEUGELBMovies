//
//  MovieDetailsPresenter.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol MovieDetailsView: AnyObject {
    func setupUI()
    func showLoadingState()
    func hideLoadingState()
    func displayMovieRetrievalError(title: String, message: String)
    func setupMovieInformaiton()
}

protocol MovieDetailsPresenter {
    var moviePoster: URL { get }
    var movieTitle: String { get }
    var movieOverview: String { get }
    var movieReleaseDate: String { get }
    var moviePopularity: Double { get }
    var router: MovieDetailsViewRouter { get }
    
    func viewDidLoad()
    func dismissButtonPressed()
}

class MovieDetailsPresenterImplementation: MovieDetailsPresenter {
    
    fileprivate weak var view: MovieDetailsView?
    internal let router: MovieDetailsViewRouter
    fileprivate let movie: Movie
    
    init(view: MovieDetailsView,
         movie: Movie,
         router: MovieDetailsViewRouter) {
        self.view = view
        self.movie = movie
        self.router = router
    }
    
    // MARK: - MovieDetailsPresenter
    
    var movieTitle: String {
        return movie.title ?? ""
    }
    
    var movieOverview: String {
        return movie.overview ?? ""
    }
    
    var moviePoster: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")!
    }
    
    var movieReleaseDate: String {
        return "Release Date: \(movie.releaseDate ?? "UNKNOWN")"
    }
    
    var moviePopularity: Double {
        return movie.popularity ?? 0.0
    }
    
    func viewDidLoad() {
        view?.setupUI()
        view?.showLoadingState()
        
        // This asyncAfter is just to show of loading animation if we are
        // going to load the movie details from an API
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.loadMovieInformation()
        }
    }
    
    func dismissButtonPressed() {
        
        router.dismissView()
    }
    
    // MARK: - Private Funcitons
    
    private func loadMovieInformation() {
        view?.hideLoadingState()
        view?.setupMovieInformaiton()
    }
    
}
