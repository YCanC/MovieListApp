//
//  MoviesCollectionViewCell.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 18.02.2021.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView  {
    
    static let identifier = "MoviesCollectionViewCell"
    
    let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.contentMode = .scaleToFill
        return posterImageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    var bottomView = UIView()
    
    var contentStack: UIStackView = {
        let descriptionStack = UIStackView()
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        descriptionStack.backgroundColor = .darkGray
        return descriptionStack
    }()
    
    var movie: Movie? {
        didSet{
            DispatchQueue.main.async {
                self.setupLayout()
            }
            
        }
    }
    
    private func setupLayout() {
        guard let currentMovie = movie else { return }
        
        setupFavoriteImage(currentMovie: currentMovie)
        setupTitle(currentMovie: currentMovie)
        setupPoster(currentMovie: currentMovie)
        setupContentStack()
        
    }
    
    private func setupFavoriteImage(currentMovie: Movie) {
        favoriteImageView.image = UIImage.filledStar
        if currentMovie.isFavourite() {
            favoriteImageView.isHidden = false
        } else {
            favoriteImageView.isHidden = true
        }
    }
    
    private func setupPoster(currentMovie: Movie) {
        if let posterURL = currentMovie.getPosterUrl(), let movieId = currentMovie.id {
            //movieID for saving to cache process
            posterImageView.setRemoteImage(url: posterURL, movieId: NSNumber(value: movieId))
        }
        addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            posterImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 0),
            posterImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.75),
        ])
        
    }
    
    private func setupTitle(currentMovie: Movie) {
        titleLabel.text = currentMovie.title
    }
    
    private func setupContentStack() {
        addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            contentStack.heightAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.2),
            contentStack.topAnchor.constraint(equalTo: posterImageView.bottomAnchor,constant: 0),
        ])
        contentStack.distribution = .equalCentering
        contentStack.axis = .horizontal
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(favoriteImageView)
    }
    
}
