//
//  DisplayLatestMovies.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

typealias DisplayLatestMoviesUseCaseCompletionHandler = (_ movies: Result<[Movie], Error>) -> Void

protocol DisplayLatestMoviesUseCase {
    func displayLatestMovies(at page: Int, completionHandler: @escaping DisplayLatestMoviesUseCaseCompletionHandler)
}

class DisplayLatestMoviesUseCaseImplementation: DisplayLatestMoviesUseCase {
    let latestMoviesGateway: LatestMoviesGateway
    
    init(latestMoviesGateway: LatestMoviesGateway) {
        self.latestMoviesGateway = latestMoviesGateway
    }
    
    // MARK: - DisplayLatestMoviesUseCase
    
    func displayLatestMovies(at page: Int, completionHandler: @escaping DisplayLatestMoviesUseCaseCompletionHandler) {
        self.latestMoviesGateway.fetchLatestMovies(at: page, completionHandler: { result in
            completionHandler(result)
        })
    }
    
}
