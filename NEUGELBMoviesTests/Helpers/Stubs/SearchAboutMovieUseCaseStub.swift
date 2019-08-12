//
//  SearchAboutMovieUseCaseStub.swift
//  NEUGELBMoviesTests
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import NEUGELBMovies
import Foundation

class SearchAboutMovieUseCaseStub: SearchAboutMovieUseCase {
    var resultToBeReturned: Result<[Movie], Error>!
    
    func searchAboutMovie(with searchText: String, at page: Int, completionHandler: @escaping SearchAboutMovieUseCaseCompletionHandler) {
        completionHandler(resultToBeReturned)
    }
}
