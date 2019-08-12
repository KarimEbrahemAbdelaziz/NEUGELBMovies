//
//  MovieCellViewModel.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

struct MovieCellViewModel {
    
    let title: String
    let year: String
    let rate: String
    let moviePoster: String
    
    init(title: String, year: Int, rate: Int, moviePoster: String) {
        self.moviePoster = moviePoster
        self.title = title
        self.year = "Year: \(year)"
        self.rate = "Rate: \(rate)"
    }
    
}
