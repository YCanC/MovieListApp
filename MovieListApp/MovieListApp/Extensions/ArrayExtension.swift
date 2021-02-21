//
//  ArrayExtension.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 21.02.2021.
//

import Foundation
extension Array where Element == Movie {
    
    //Saves array to local storage.
    func save() {
        do {
            let encodedMovie = try JSONEncoder().encode(self)
            UserDefaults.standard.set(encodedMovie, forKey: Constants.localStorageKey)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    //Fetches array from local storage.
    func fetchFavourites() -> [Movie]? {
        do {
            guard let savedMovies = UserDefaults.standard.value(forKey: Constants.localStorageKey) as? Data else { return nil }
            let Movies = try JSONDecoder().decode([Movie].self, from: savedMovies)
            return Movies
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    //contains control for arrays
    func contains(array: [Element]) -> Bool {
        for item in array {
            if !self.contains(item) { return false }
        }
        return true
    }
    
    
}
