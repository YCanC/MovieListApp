//
//  MovieDetailViewController.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 20.02.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var currentMovie = Movie()
    var posterImageView = UIImageView()
    var isFavourite = Bool()
    
    var descriptionStack: UIStackView = {
        let descriptionStack = UIStackView()
        descriptionStack.backgroundColor = .white
        descriptionStack.distribution = .fillProportionally
        descriptionStack.axis = .vertical
        return descriptionStack
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        return descriptionLabel
    }()
    
    var voteCountLabel = UILabel()
    var voteCount = Int()
    var bottomView = UIView()
    var addFavouriteButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBgColor
        self.isFavourite = currentMovie.isFavourite()
        setupPosterView()
        setupBottomView()
        setupDescriptionView()
        setNavBar()
    }
    
    func setupPosterView() {
        if let posterURL = currentMovie.getPosterUrl(), let movieId = currentMovie.id {
            //movieID for saving to cache process
            posterImageView.setRemoteImage(url:posterURL, movieId: NSNumber(value: movieId))
        }
        view.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            posterImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            posterImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,multiplier: 0.45),
        ])
    }
    
    
    func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = UIColor.defaultBgColor
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
        ])
        
        bottomView.addSubview(descriptionStack)
    }
    
    func setupDescriptionView() {
        
        titleLabel.text = currentMovie.title
        descriptionLabel.text =  currentMovie.overview
        voteCount =  currentMovie.vote_count!
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            descriptionStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
            descriptionStack.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5),
            descriptionStack.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 10),
        ])
        
        voteCountLabel.text = "Vote Count : \(voteCount)"
        voteCountLabel.textColor = .lightGray
        descriptionStack.addArrangedSubview(titleLabel)
        descriptionStack.addArrangedSubview(descriptionLabel)
        descriptionStack.addArrangedSubview(voteCountLabel)
    }
    
    private func setNavBar() {
        self.navigationItem.title = "Content"
        if isFavourite {
            addFavouriteButton = UIBarButtonItem(image: UIImage.filledStar, style: .done, target: self, action: #selector(tabbedStarIcon))
        } else {
            addFavouriteButton = UIBarButtonItem(image: UIImage.emptyStar, style: .done, target: self, action: #selector(tabbedStarIcon))
        }
        self.navigationItem.rightBarButtonItem  = addFavouriteButton
    }
    
    @objc func tabbedStarIcon() {
        if isFavourite {
            currentMovie.removeFromFavourites()
            addFavouriteButton.image = UIImage.emptyStar
        } else {
            currentMovie.addIssueToFavourites()
            addFavouriteButton.image = UIImage.filledStar
        }
    }
    
}
