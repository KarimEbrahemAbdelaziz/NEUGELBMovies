//
//  MoviesConfigurator.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol MoviesConfigurator {
    func configure(moviesViewController: MoviesViewController)
}

class MoviesConfiguratorImplementation: MoviesConfigurator {
    
    func configure(moviesViewController: MoviesViewController) {
        
        let networkMoviesGateway = APIMoviesGatewayImplementation()
        let displayMoviesUseCase = DisplayLatestMoviesUseCaseImplementation(latestMoviesGateway: networkMoviesGateway)
        let searchAboutMovieUseCase = SearchAboutMovieUseCaseImplementation(searchAboutMovieGateway: networkMoviesGateway)
        let router = MoviesViewRouterImplementation(moviesViewController: moviesViewController)
        
        let presenter = MoviesPresenterImplementation(view: moviesViewController,
                                                      displayMoviesUseCase: displayMoviesUseCase, searchAboutMovieUseCase: searchAboutMovieUseCase,
                                                      router: router)
        
        moviesViewController.presenter = presenter
        
    }
}
