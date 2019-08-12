//
//  APIMovie.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import ObjectMapper

class APIMovie: Mappable {
    
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
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.popularity <- map["popularity"]
        self.voteCount <- map["vote_count"]
        self.voteAverage <- map["vote_average"]
        self.posterPath <- map["poster_path"]
        self.originalTitle <- map["original_title"]
        self.originalLanguage <- map["original_language"]
        self.overview <- map["overview"]
        self.releaseDate <- map["release_date"]
        self.genreIds <- map["genre_ids"]
    }
    
}

extension APIMovie {
    var movie: Movie {
        return Movie(id: self.id, title: self.title, popularity: self.popularity, voteCount: self.voteCount, voteAverage: self.voteAverage, posterPath: self.posterPath, originalTitle: self.originalTitle, originalLanguage: self.originalLanguage, overview: self.overview, releaseDate: self.releaseDate, genreIds: self.genreIds)
    }
}
