//
//  CrashlyticsReport.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 14.06.22.
//

import Foundation
import Firebase

// MARK: - Crashlytics Error Code
public enum CrashlyticsCode: Int {
    case failureResponse = 1000
    case rejectionResult = 1001
    case undefinedBehavior = 1002
}

final class CrashlyticsReport {
    private(set) var domain: String = NSCocoaErrorDomain
    private(set) var userInfo: [String: Any] = [:]
    
    // MARK: - Custom Simple report
    public func report(error: String, code: CrashlyticsCode.RawValue) {
        let error = NSError.init(domain: domain, code: code, userInfo: ["error": error])
        Crashlytics.crashlytics().record(error: error)
    }
    
    public func reportWithUserInfo(userId: Int) {
        let userInfo = [
          "userId": "\(userId)",
          "error": "Пользователь не ввел данные."
        ]
        let error = NSError.init(domain: domain, code: CrashlyticsCode.undefinedBehavior.rawValue, userInfo: userInfo)
        Crashlytics.crashlytics().record(error: error)
    }
}
