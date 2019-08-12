//
//  MovieCellViewSpy.swift
//  NEUGELBMoviesTests
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import NEUGELBMovies
import Foundation

class MovieCellViewSpy: MovieCellView {
    var displayedTitle = ""
    
    func configure(with viewModel: MovieCellViewModel) {
        displayedTitle = viewModel.title
    }
}
