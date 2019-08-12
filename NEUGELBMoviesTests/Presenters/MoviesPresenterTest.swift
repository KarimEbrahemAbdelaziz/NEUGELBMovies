//
//  MoviesPresenterTest.swift
//  NEUGELBMoviesTests
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import NEUGELBMovies
import XCTest

class MoviesPresenterTest: XCTestCase {
    
    let diplayMoviesUseCaseStub = DisplayLatestMoviesUseCaseStub()
    let searchAboutMovieUseCaseStub = SearchAboutMovieUseCaseStub()
    let moviesViewRouterSpy = LatestMoviesViewRouterSpy()
    let moviesViewSpy = MoviesViewSpy()
    
    var moviesPresenter: MoviesPresenterImplementation!
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        
        moviesPresenter = MoviesPresenterImplementation(view: moviesViewSpy,
                                                        displayMoviesUseCase: diplayMoviesUseCaseStub, searchAboutMovieUseCase: searchAboutMovieUseCaseStub,
                                                        router: moviesViewRouterSpy)
    }
    
    // MARK: - Tests
    
    func test_viewDidLoad_success_refreshBooksView_called() {
        // Given
        let moviesToBeReturned = Movie.createMoviesArray()
        diplayMoviesUseCaseStub.resultToBeReturned = .success(moviesToBeReturned)
        
        // When
        moviesPresenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(moviesViewSpy.refreshMoviesViewCalled, "refreshMoviesView was not called")
    }
    
    func test_viewDidLoad_success_numberOfMovies() {
        // Given
        let expectedNumberOfMovies = 5
        let moviesToBeReturned = Movie.createMoviesArray(numberOfElements: expectedNumberOfMovies)
        diplayMoviesUseCaseStub.resultToBeReturned = .success(moviesToBeReturned)
        
        // When
        moviesPresenter.viewDidLoad()
        
        // Then
        XCTAssertEqual(expectedNumberOfMovies, moviesPresenter.numberOfMovies, "Number of movies mismatch")
    }
    
    func test_viewDidLoad_failure_displayMoviesRetrievalError() {
        // Given
        let expectedErrorTitle = "Error"
        let expectedErrorMessage = "Some error message"
        let errorToBeReturned = NSError.createError(withMessage: expectedErrorMessage)
        diplayMoviesUseCaseStub.resultToBeReturned = .failure(errorToBeReturned)
        
        // When
        moviesPresenter.viewDidLoad()
        
        // Then
        XCTAssertEqual(expectedErrorTitle, moviesViewSpy.displayLatestMoviesRetrievalErrorTitle, "Error title doesn't match")
        XCTAssertEqual(expectedErrorMessage, moviesViewSpy.displayLatestMoviesRetrievalErrorMessage, "Error message doesn't match")
    }
    
    func test_configureCell_has_release_date() {
        // Given
        moviesPresenter.movies = Movie.createMoviesArray()
        moviesPresenter.searchResultMovies = Movie.createMoviesArray()
        let expectedDisplayedTitle = "1"
        
        let movieCellViewSpy = MovieCellViewSpy()
        
        // When
        moviesPresenter.configure(cell: movieCellViewSpy, forRow: 1)
        
        // Then
        XCTAssertEqual(expectedDisplayedTitle, movieCellViewSpy.displayedTitle, "The title we expected was not displayed")
    }
    
    func test_didSelect_navigates_to_details_view() {
        // Given
        let movies = Movie.createMoviesArray()
        let rowToSelect = 1
        moviesPresenter.movies = movies
        moviesPresenter.searchResultMovies = movies
        
        // When
        moviesPresenter.didSelect(row: rowToSelect)
        
        // Then
        XCTAssertEqual(movies[rowToSelect], moviesViewRouterSpy.passedMovie, "Expected navigate to details view to be called with movie at index 1")
    }
    
}
