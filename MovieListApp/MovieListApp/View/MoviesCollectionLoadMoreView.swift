//
//  MoviesCollectionReusableView.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 19.02.2021.
//

import UIKit

class MoviesCollectionLoadMoreView: UICollectionReusableView {
    static let identifier = "MoviesCollectionReusableViewID"
    
    let loadMoreButton: UIButton = {
        var loadMoreButton = UIButton()
        loadMoreButton.setTitle("load more", for: .normal)
        loadMoreButton.setTitleColor(.blue, for: .normal)
        return loadMoreButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loadMoreButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadMoreButton.frame = bounds
    }
}
