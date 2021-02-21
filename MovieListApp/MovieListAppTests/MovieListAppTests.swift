//
//  MovieListAppTests.swift
//  MovieListAppTests
//
//  Created by yasar.cilingir on 18.02.2021.
//

import XCTest
@testable import MovieListApp

class MovieListAppTests: XCTestCase {
    
    func testServerResponse() {
        let expectation = self.expectation(description: "Server responds in reasonable time")
        defer { waitForExpectations(timeout: 2) }
        
        let router = Router.getMovies(page: 1)
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        guard let url = components.url else { return }
     
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { expectation.fulfill() }
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
        }
        .resume()
    }
    
    
    func PosterURLTest() {
        let posterUrlString = Constants.basePosterUrl
           let expectedPosterURL = "https://image.tmdb.org/t/p/w400"
           XCTAssertEqual(posterUrlString, expectedPosterURL, "Poster URL does not the same expected Poster URL")
    }

}
