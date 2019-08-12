//
//  DisplayLatestMovies.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

typealias FetchLatestMoviesEntityGatewayCompletionHandler = (_ movies: Result<[Movie], Error>) -> Void

protocol LatestMoviesGateway {
    func fetchLatestMovies(at page: Int, completionHandler: @escaping FetchLatestMoviesEntityGatewayCompletionHandler)
}
