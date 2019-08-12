//
//  MovieDetailsViewRouter.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol MovieDetailsViewRouter: ViewRouter {
    func dismissView()
}

class MovieDetailsViewRouterImplementation: MovieDetailsViewRouter {
    fileprivate weak var movieDetailsViewController: MovieDetailsViewController?
    
    init(movieDetailsViewController: MovieDetailsViewController) {
        self.movieDetailsViewController = movieDetailsViewController
    }
    
    func dismissView() {
        movieDetailsViewController?.navigationController?.popViewController(animated: true)
    }
}
