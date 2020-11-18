//
//  InternalURL.swift
//  Mesa News
//
//  Created by Diana Monteiro on 18/11/20.
//

import Foundation

struct InternalUrl {
    private let baseUrl = "https://mesa-news-api.herokuapp.com/v1/client/"
    var endpoint: Endpoint
    
    enum Endpoint {
        case signIn(User)
        case signUp(User)
        case news(token: String)
        case highlights(token: String)
        
        fileprivate var urlAddition: String {
            switch self {
            case .signIn: return "auth/signin"
            case .signUp: return "auth/signup"
            case .news: return "news"
            case .highlights: return "news/highlights"
            }
        }
        
        fileprivate var httpMethod: HttpMethod {
            switch self {
            case .signIn, .signUp: return .post
            case .news, .highlights: return .get
            }
        }
        
        func encodeBodyData() -> Data? {
            switch self {
            case .signIn(let user), .signUp(let user): return user.encode()
            case .news(token: _), .highlights(token: _): return nil
            }
        }
    }
    
    fileprivate enum HttpMethod: String {
        case post
        case get
        
        fileprivate var httpMethodString: String {
            self.rawValue.uppercased()
        }
    }
    
    func joinedUrl() -> URL {
        return URL(string: "\(baseUrl)\(endpoint.urlAddition)")!
    }
    
    func createRequest() -> URLRequest {
        var request = URLRequest(url: joinedUrl(),timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = endpoint.httpMethod.httpMethodString
        request.httpBody = endpoint.encodeBodyData()
        return request
    }
}
