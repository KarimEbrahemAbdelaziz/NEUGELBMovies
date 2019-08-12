//
//  Movie.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

struct Movie {
    
    var id: Int?
    var title: String?
    var popularity: Double?
    var voteCount: Int?
    var voteAverage: Double?
    var posterPath: String?
    var originalTitle: String?
    var originalLanguage: String?
    var overview: String?
    var releaseDate: String?
    var genreIds: [Genre]?
    
}

struct Genre {
    
    var id: Int
    var name: String
    
}
