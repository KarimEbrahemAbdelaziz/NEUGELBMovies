//
//  MoviesRouter.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import Alamofire
import Keys.NEUGELBMoviesKeys

enum MoviesRouter: URLRequestConvertible {
    
    static let baseURLString = "https://api.themoviedb.org/3"
    static let cocoaPodsKeys = NEUGELBMoviesKeys()
    
    case fetchLatestMovies(page: Int)
    case searchAboutMovie(movieTitle: String, page: Int)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .fetchLatestMovies, .searchAboutMovie:
                return .get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .fetchLatestMovies, .searchAboutMovie:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case .fetchLatestMovies:
                relativePath = MoviesRouter.baseURLString + "/discover/movie"
            case .searchAboutMovie:
                relativePath = MoviesRouter.baseURLString + "/search/movie"
            }
            
            var url: URL!
            if let relativePath = relativePath {
                switch self {
                case let .fetchLatestMovies(page):
                    
                    let queryItems = [URLQueryItem(name: "text", value: relativePath)]
                    var urlComps = URLComponents(string: relativePath)!
                    urlComps.queryItems = queryItems
                    url = try! urlComps.asURL()
                    url = url.appending("api_key", value: MoviesRouter.cocoaPodsKeys.tMDBAPIKey)
                    url = url.appending("sort_by", value: "release_date.desc")
                    url = url.appending("primary_release_year", value: "2019")
                    url = url.appending("page", value: "\(page)")
                case let .searchAboutMovie(movieTitle, page):
                    let queryItems = [URLQueryItem(name: "text", value: relativePath)]
                    var urlComps = URLComponents(string: relativePath)!
                    urlComps.queryItems = queryItems
                    url = try! urlComps.asURL()
                    url = url.appending("api_key", value: MoviesRouter.cocoaPodsKeys.tMDBAPIKey)
                    url = url.appending("query", value: movieTitle)
                    url = url.appending("page", value: "\(page)")
                }
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            return JSONEncoding.default
        }()
        return try! encoding.encode(urlRequest, with: params)
    }
}
