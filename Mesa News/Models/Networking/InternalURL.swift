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
    
    enum Endpoint:CustomStringConvertible {
        var description: String {
            switch self {
            case .signIn: return "signIn"
            case .signUp: return "signUp"
            case .news: return "news"
            case .highlights: return "highlights"
            }
        }
        
        case signIn(User)
        case signUp(User)
        case news
        case highlights
        
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
            case .news, .highlights: return nil
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
        if let token = ActiveUser.shared.token {
            request.addValue(token, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
