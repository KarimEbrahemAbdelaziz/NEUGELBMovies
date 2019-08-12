//
//  SearchAboutMovie.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

typealias SearchAboutMovieUseCaseCompletionHandler = (_ movies: Result<[Movie], Error>) -> Void

protocol SearchAboutMovieUseCase {
    func searchAboutMovie(with searchText: String, at page: Int, completionHandler: @escaping SearchAboutMovieUseCaseCompletionHandler)
}

class SearchAboutMovieUseCaseImplementation: SearchAboutMovieUseCase {
    let searchAboutMovieGateway: SearchAboutMovieGateway
    
    init(searchAboutMovieGateway: SearchAboutMovieGateway) {
        self.searchAboutMovieGateway = searchAboutMovieGateway
    }
    
    // MARK: - SearchAboutMovieUseCase
    
    func searchAboutMovie(with searchText: String, at page: Int, completionHandler: @escaping DisplayLatestMoviesUseCaseCompletionHandler) {
        self.searchAboutMovieGateway.searchAboutMovie(with: searchText, at: page, completionHandler: { result in
            completionHandler(result)
        })
    }
    
}
