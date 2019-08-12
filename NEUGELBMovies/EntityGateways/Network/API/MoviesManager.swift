//
//  MoviesManager.swift
//  NEUGELBMovies
//
//  Created by Karim Ebrahem on 8/12/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Alamofire
import Foundation
import ObjectMapper

class MoviesManager {
    
    enum MoviesManagerError: Error {
        case parseFailed
        case customError(message: String)
        case networkError
    }
    
    static func fetchLatestMovies(at page: Int, _ completionHandler: @escaping (Swift.Result<[APIMovie], MoviesManagerError>) -> Void) {
        let request = MoviesRouter.fetchLatestMovies(page: page)
        Alamofire.request(request).responseJSON { response in
            switch response.result {
            case let .success(value):
                guard let jsonArray = value as? [String: Any] else {
                    completionHandler(.failure(MoviesManagerError.parseFailed))
                    return
                }
                guard let results = jsonArray["results"] as? [[String: Any]] else {
                    if let errors = jsonArray["errors"] as? [String] {
                        completionHandler(.failure(MoviesManagerError.customError(message: errors.first ?? "TheMovieDatabase couldn't perform the request!")))
                        return
                    } else {
                        completionHandler(.failure(MoviesManagerError.parseFailed))
                        return
                    }
                }
                
                let latestMovies = Mapper<APIMovie>().mapArray(JSONArray: results)
                completionHandler(.success(latestMovies))
            case .failure:
                completionHandler(.failure(MoviesManagerError.networkError))
            }
        }
    }
    
    static func searchAboutMovie(with searchText: String, at page: Int, _ completionHandler: @escaping (Swift.Result<[APIMovie], MoviesManagerError>) -> Void) {
        let request = MoviesRouter.searchAboutMovie(movieTitle: searchText, page: page)
        Alamofire.request(request).responseJSON { response in
            switch response.result {
            case let .success(value):
                guard let jsonArray = value as? [String: Any] else {
                    completionHandler(.failure(MoviesManagerError.parseFailed))
                    return
                }
                guard let results = jsonArray["results"] as? [[String: Any]] else {
                    if let errors = jsonArray["errors"] as? [String] {
                        completionHandler(.failure(MoviesManagerError.customError(message: errors.first ?? "TheMovieDatabase couldn't perform the request!")))
                        return
                    } else {
                        completionHandler(.failure(MoviesManagerError.parseFailed))
                        return
                    }
                }
                
                let latestMovies = Mapper<APIMovie>().mapArray(JSONArray: results)
                completionHandler(.success(latestMovies))
            case .failure:
                completionHandler(.failure(MoviesManagerError.networkError))
            }
        }
    }
    
}
