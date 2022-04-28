//
//  AppDelegate.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 21.04.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let requestFactory = RequestFactory()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let auth = requestFactory.makeAuthRequestFatory()
        let product = requestFactory.makeProductRequestFactory()
        
        auth.register(username: "Zasenko", password: "12345", email: "dmitry.zasenko@gmail.com", gender: .male, creditCard: "5555555", bio: "bad boy") { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        auth.changeUserData(username: "Dmitry", password: "12345", email: "dmitry.zasenko@gmail.com", gender: .male, creditCard: "5555555", bio: "good boy") { response in
            
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        auth.logout { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        product.getProducts(id: 1, page: 1) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        product.getProduckById(id: 1) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
