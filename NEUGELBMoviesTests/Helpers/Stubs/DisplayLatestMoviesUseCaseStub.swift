//
//  DisplayLatestMoviesUseCaseStub.swift
//  NEUGELBMoviesTests
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import NEUGELBMovies
import Foundation

class DisplayLatestMoviesUseCaseStub: DisplayLatestMoviesUseCase {
    var resultToBeReturned: Result<[Movie], Error>!
    
    func displayLatestMovies(at page: Int, completionHandler: @escaping DisplayLatestMoviesUseCaseCompletionHandler) {
        completionHandler(resultToBeReturned)
    }
}
