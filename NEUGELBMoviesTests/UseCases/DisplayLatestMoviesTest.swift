//
//  DisplayLatestMoviesTest.swift
//  NEUGELBMoviesTests
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import NEUGELBMovies
import XCTest

class DisplayMoviesTest: XCTestCase {
    
    let latestMoviesGatewaySpy = LatestMoviesGatewaySpy()
    var displayLatestMoviesUseCase: DisplayLatestMoviesUseCase!
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        
        displayLatestMoviesUseCase = DisplayLatestMoviesUseCaseImplementation(latestMoviesGateway: latestMoviesGatewaySpy)
    }
    
    // MARK: - Tests
    
    func test_fetch_success_calls_completion_handler() {
        // Given
        let expectedResultToBeReturned: Result<[Movie], Error> = Result.success([])
        latestMoviesGatewaySpy.fetchLatestMoviesResultToBeReturned = expectedResultToBeReturned
        
        let fetchLatestMoviesCompletionHandlerExpectation = expectation(description: "Fetch Latest Movies Expectation")
        
        // When
        displayLatestMoviesUseCase.displayLatestMovies(at: 1, completionHandler: { result in
            // Then
            switch result {
            case .success(let value):
                let successValue = try! expectedResultToBeReturned.get()
                XCTAssertEqual(successValue.count, value.count, "Completion handler didn't return the expected result")
            case .failure:
                break
            }
            fetchLatestMoviesCompletionHandlerExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_fetch_failuer_calls_completion_handler() {
        // Given
        let expectedResultToBeReturned: Result<[Movie], Error> = Result.failure(MoviesManager.MoviesManagerError.networkError)
        latestMoviesGatewaySpy.fetchLatestMoviesResultToBeReturned = expectedResultToBeReturned
        
        let fetchLatestMoviesCompletionHandlerExpectation = expectation(description: "Fetch Movies Expectation")
        
        // When
        displayLatestMoviesUseCase.displayLatestMovies(at: 1, completionHandler: { result in
            // Then
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTAssertNotNil(error, "Completion handler didn't get called")
            }
            fetchLatestMoviesCompletionHandlerExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
