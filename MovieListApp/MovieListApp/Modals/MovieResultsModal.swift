//
//  MovieResultsModal.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 18.02.2021.
//

import Foundation

struct MovieResultsModal: Codable {
    var results: [Movie]?
}

struct Movie: Codable, Equatable {
    var title: String?
    var poster_path: String?
    var overview: String?
    var vote_count: Int?
    var id: Int?
}
