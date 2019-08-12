//
//  Movie+Extensions.swift
//  NEUGELBMoviesTests
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import NEUGELBMovies
import Foundation

extension Movie {
    static func createMoviesArray(numberOfElements: Int = 2) -> [Movie] {
        var movies = [Movie]()
        
        for identifire in 0..<numberOfElements {
            let movie = createMovie(index: identifire)
            movies.append(movie)
        }
        
        return movies
    }
    
    static func createMovie(index: Int = 0) -> Movie {
        return Movie(id: index, title: "\(index)", popularity: Double(index), voteCount: index, voteAverage: Double(index), posterPath: "\(index)", originalTitle: "\(index)", originalLanguage: "\(index)", overview: "\(index)", releaseDate: "\(index)", genreIds: [])
    }
}

extension Movie: Equatable { }

public func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.title == rhs.title
}
