//
//  LatestMoviesViewSpy.swift
//  NEUGELBMoviesTests
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import NEUGELBMovies
import Foundation

class MoviesViewSpy: MoviesView {
    
    var refreshMoviesViewCalled = false
    var displayLatestMoviesRetrievalErrorTitle: String?
    var displayLatestMoviesRetrievalErrorMessage: String?
    
    func refreshMoviesView() {
        refreshMoviesViewCalled = true
    }
    
    func displayMoviesRetrievalError(title: String, message: String) {
        displayLatestMoviesRetrievalErrorTitle = title
        displayLatestMoviesRetrievalErrorMessage = message
    }
    
    func refreshAutoCompleteData() {
        
    }
    
}
