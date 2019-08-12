//
//  MovieDetailsViewController.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Cosmos
import Foundation
import Kingfisher
import SkeletonView
import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var backgroundMovieImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieOverviewLabel: UILabel!
    @IBOutlet private weak var movieRateCosmosView: CosmosView!
    
    // MARK: - Properties
    
    var configurator: MovieDetailsConfiguratorImplementation!
    var presenter: MovieDetailsPresenter!
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(movieDetailsViewController: self)
        presenter.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction private func backToMovies(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Functions
    
    private func setupMovieImageView() {
        movieImage.isSkeletonable = true
        
        movieImage.layer.cornerRadius = 16
        movieImage.clipsToBounds = true
        movieImage.layer.shadowColor = UIColor.lightGray.cgColor
        movieImage.layer.shadowOpacity = 0.5
        movieImage.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    private func setupLabels() {
        movieTitleLabel.isSkeletonable = true
        movieYearLabel.isSkeletonable = true
        movieOverviewLabel.isSkeletonable = true
    }
    
    private func setupRatingCosmosView() {
        movieRateCosmosView.isSkeletonable = true
        movieRateCosmosView.isUserInteractionEnabled = false
    }
    
    private func setGradientBackground() {
        let bottomColor =  UIColor.yellowCustom.cgColor
        let topColor = UIColor.pinkCustom.cgColor
        
        self.setGradientBackground(topColor: topColor, bottomColor: bottomColor)
    }
    
    private func showLoadingSkeleton() {
        let halfAlphaWhite = UIColor.white.withAlphaComponent(0.3)
        let halfAlphaBlue = UIColor.yellowCustom.withAlphaComponent(0.3)
        let gradiant = SkeletonGradient(baseColor: halfAlphaBlue, secondaryColor: halfAlphaWhite)
        
        movieImage.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieTitleLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieYearLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieRateCosmosView.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieOverviewLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
    }
    
    private func hideLoadingSkeleton() {
        movieImage.hideSkeleton()
        movieTitleLabel.hideSkeleton()
        movieYearLabel.hideSkeleton()
        movieRateCosmosView.hideSkeleton()
        movieOverviewLabel.hideSkeleton()
    }
    
    private func setupMovieDetails() {
        movieTitleLabel.text = presenter.movieTitle
        movieYearLabel.text = presenter.movieReleaseDate
        movieRateCosmosView.rating = presenter.moviePopularity
        movieImage.kf.setImage(with: presenter.moviePoster, placeholder: UIImage(named: "moviePlaceholder"))
        backgroundMovieImage.kf.setImage(with: presenter.moviePoster)
        movieOverviewLabel.text = presenter.movieOverview
    }
    
}

// MARK: - MovieDetailsView

extension MovieDetailsViewController: MovieDetailsView {
    func showLoadingState() {
        showLoadingSkeleton()
    }
    
    func hideLoadingState() {
        hideLoadingSkeleton()
    }
    
    func setupUI() {
        setGradientBackground()
        setupMovieImageView()
        setupRatingCosmosView()
        setupLabels()
    }
    
    func displayMovieRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
    
    func setupMovieInformaiton() {
        setupMovieDetails()
    }
}
