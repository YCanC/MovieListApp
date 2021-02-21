//
//  ServiceTarget.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 18.02.2021.
//

import Foundation

protocol Service {
    func getMovies(page: Int, completion: @escaping (Result<MovieResultsModal, Error>) -> Void)
}

struct ServiceImplementation: Service {
    
    func getMovies(page: Int, completion: @escaping (Result<MovieResultsModal, Error>) -> Void) {
        ServiceLayer.request(router: .getMovies(page: page), completion: completion)
    }
    
}
