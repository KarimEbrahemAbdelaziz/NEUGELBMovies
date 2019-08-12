//
//  MovieCell.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var moviePoster: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moviePoster.layer.cornerRadius = 16
    }
    
}

// MARK: - MovieCellView

extension MovieCell: MovieCellView {
    func configure(with viewModel: MovieCellViewModel) {
        self.moviePoster.kf.indicatorType = .activity
        if !viewModel.moviePoster.isEmpty {
            self.moviePoster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.moviePoster)")!, placeholder: UIImage(named: "moviePlaceholder"), options: [.transition(.fade(0.1))])
        } else {
            self.moviePoster.image = UIImage(named: "moviePlaceholder")
        }
        self.titleLabel.text = viewModel.title.isEmpty ? "No Title Yet" : viewModel.title
    }
}
