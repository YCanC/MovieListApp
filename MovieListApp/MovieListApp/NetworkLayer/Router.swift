//
//  Router.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 18.02.2021.
//

import Foundation

enum Router {
    
    case getMovies(page: Int)

    var scheme: String {
        switch self {
        case .getMovies:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getMovies:
            return "api.themoviedb.org"
        }
    }

    var path: String {
        switch self {
        case .getMovies:
            return "/3/movie/popular"
        }
    }

    var parameters: [URLQueryItem] {
        let apiKey = "fd2b04342048fa2d5f728561866ad52a"
        switch self {
        case .getMovies(let page):
            return [URLQueryItem(name: "language", value: "enUS"),
                    URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "page", value: "\(page)")]
        }
    }

    var method: String {
        switch self {
        case .getMovies:
            return "GET"
        }
    }
    
}
