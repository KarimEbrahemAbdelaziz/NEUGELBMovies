//
//  SearchAboutMovieGateway.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

typealias SearchAboutMovieEntityGatewayCompletionHandler = (_ movies: Result<[Movie], Error>) -> Void

protocol SearchAboutMovieGateway {
    func searchAboutMovie(with searchText: String, at page: Int, completionHandler: @escaping SearchAboutMovieEntityGatewayCompletionHandler)
}
