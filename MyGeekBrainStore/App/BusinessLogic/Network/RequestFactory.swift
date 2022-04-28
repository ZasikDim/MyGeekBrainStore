//
//  RequestFactory.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 25.04.22.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var requestFactorySession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return AuthRequest(errorParser: errorParser, sessionManager: requestFactorySession, queue: sessionQueue)
    }
    
    func makeProductRequestFactory() -> ProductRequestFactory {
        let errorParser = makeErrorParser()
        return ProductRequest(errorParser: errorParser, sessionManager: requestFactorySession, queue: sessionQueue)
    }
}
