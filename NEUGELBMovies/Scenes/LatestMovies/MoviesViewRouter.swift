//
//  MoviesRouter.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import UIKit

protocol MoviesViewRouter: ViewRouter {
    func presentDetailsView(for movie: Movie)
}

class MoviesViewRouterImplementation: MoviesViewRouter {
    fileprivate weak var moviesViewController: MoviesViewController?
    fileprivate var movie: Movie!
    
    init(moviesViewController: MoviesViewController) {
        self.moviesViewController = moviesViewController
    }
    
    // MARK: - BooksViewRouter
    
    func presentDetailsView(for movie: Movie) {
        self.movie = movie
        moviesViewController?.performSegue(withIdentifier: "MoviesSceneToMovieDetailsSceneSegue", sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailsTableViewController = segue.destination as? MovieDetailsViewController {
            movieDetailsTableViewController.configurator = MovieDetailsConfiguratorImplementation(movie: movie)
        }
    }
    
}
