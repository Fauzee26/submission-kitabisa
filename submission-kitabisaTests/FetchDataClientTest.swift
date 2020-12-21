//
//  FetchDataClientTest.swift
//  submission-kitabisaTests
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import XCTest
@testable import submission_kitabisa

class FetchDataClientTest: XCTestCase {

    var mainPresenter: MainPresenter!
    var mockMainDelegate: MainDelegateMock!
    
    override func setUpWithError() throws {
        mockMainDelegate = MainDelegateMock()
        mainPresenter = MainPresenter(delegate: mockMainDelegate)
    }

    override func tearDownWithError() throws {
        mainPresenter = nil
    }

    func testPerformanceExample() throws {
        self.measure {
            mainPresenter.fetchListMovies(type: .topRated)
        }
    }

    func testShouldReturnDataFromURLSession() {
        mainPresenter.fetchListMovies(type: .popular)
        
        XCTAssertNotNil(mockMainDelegate.moviesList)
    }
}

class MainDelegateMock: MainDelegate {
    var moviesList = [MovieModel]()
    
    func loadMoviesSuccess(movies: [MovieModel]) {
        moviesList = movies
    }
    
    func loadMoviesFail(error: String) {
        //
    }
    
    
}
