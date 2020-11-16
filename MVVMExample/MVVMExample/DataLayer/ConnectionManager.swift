//
//  ConnectionManager.swift
//  MVVMExample
//
//  Created by macbook on 11/13/20.
//

enum HTTPMethod: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
}

import Foundation
import RxSwift

// MARK: public interface
class ConnectionManager {
    // MARK: singleton
    static let shared = ConnectionManager()
    
    func getPopularMovies() -> Observable<[Movie]> {
        
        return Observable.create { observer -> Disposable in
            guard let request = BaseRequest.createRequest(url: Constants.Endpoints.urlListPopularMovies,
                                                          method: .get) else {
                return Disposables.create()
            }
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                    return
                }
                
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.listOfMovies)
                    } catch let error {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
                } else if response.statusCode == 401 {
                    
                }
                observer.onCompleted()
         }.resume()

            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
            
        }
    }
}


// MARK: private interface
fileprivate class BaseRequest {
    
    fileprivate static func createRequest(url: String, method: HTTPMethod) -> URLRequest? {
        guard let unwrappedUrl = URL(string: url) else {
            return nil
        }
        var request = URLRequest.init(url: unwrappedUrl)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        return request
    }
}
