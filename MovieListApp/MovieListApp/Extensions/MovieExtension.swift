//
//  MovieExtension.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 22.02.2021.
//

import Foundation
extension Movie {
    /// This function is preparing  movie poster url
    func getPosterUrl()-> URL? {
        var urlString = String()
        
        if let posterPath = self.poster_path {
            urlString = "\(Constants.basePosterUrl)\(posterPath)"
        }
        guard let url = URL(string: urlString) else { return nil  }
        return url
    }
    
    ///This function is for adding movie to favorites
    func addIssueToFavourites() {
        GlobalVariables.favouriteMovies.append(self)
        GlobalVariables.favouriteMovies.save()
    }
    
    /// This function checks favourite movie status from user local storage
    func isFavourite() -> Bool {
        for currentMovie in GlobalVariables.favouriteMovies {
            if currentMovie.id == self.id {
                return true
            }
        }
        return false
    }
    
    ///This function is for removing favorite movies in user local storage
    func removeFromFavourites() {
        var movieIndex = 0
        for currentIssue in GlobalVariables.favouriteMovies {
            if currentIssue.id == self.id {
                GlobalVariables.favouriteMovies.remove(at: movieIndex)
                GlobalVariables.favouriteMovies.save()
                return
            }
            movieIndex+=1
        }
    }
}
