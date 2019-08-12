//
//  LatestMoviesGatewaySpy.swift
//  NEUGELBMoviesTests
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import NEUGELBMovies
import Foundation

class LatestMoviesGatewaySpy: LatestMoviesGateway {
    var fetchLatestMoviesResultToBeReturned: Result<[Movie], Error>!
    
    func fetchLatestMovies(at page: Int, completionHandler: @escaping FetchLatestMoviesEntityGatewayCompletionHandler) {
        completionHandler(fetchLatestMoviesResultToBeReturned)
    }
}
