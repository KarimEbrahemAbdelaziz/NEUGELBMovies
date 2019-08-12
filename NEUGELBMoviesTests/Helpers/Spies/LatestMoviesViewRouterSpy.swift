//
//  LatestMoviesViewRouterSpy.swift
//  NEUGELBMoviesTests
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import NEUGELBMovies
import Foundation

class LatestMoviesViewRouterSpy: MoviesViewRouter {
    
    var passedMovie: Movie!
    
    func presentDetailsView(for movie: Movie) {
        passedMovie = movie
    }
    
}
