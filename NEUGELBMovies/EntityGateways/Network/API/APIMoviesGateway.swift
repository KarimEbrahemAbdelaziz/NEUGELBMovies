//
//  APIMoviesGateway.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol APIMoviesGateway: LatestMoviesGateway, SearchAboutMovieGateway {
    
}

class APIMoviesGatewayImplementation: APIMoviesGateway {
    func fetchLatestMovies(at page: Int, completionHandler: @escaping FetchLatestMoviesEntityGatewayCompletionHandler) {
        MoviesManager.fetchLatestMovies(at: page) { (result: Result<[APIMovie], MoviesManager.MoviesManagerError>) in
            switch result {
            case let .success(response):
                let movies = response.map({ apiMovie -> Movie in
                    return apiMovie.movie
                })
                completionHandler(.success(movies))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func searchAboutMovie(with searchText: String, at page: Int, completionHandler: @escaping SearchAboutMovieEntityGatewayCompletionHandler) {
        MoviesManager.searchAboutMovie(with: searchText, at: page) { (result: Result<[APIMovie], MoviesManager.MoviesManagerError>) in
            switch result {
            case let .success(response):
                let movies = response.map({ apiMovie -> Movie in
                    return apiMovie.movie
                })
                completionHandler(.success(movies))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
