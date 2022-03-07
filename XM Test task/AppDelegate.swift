//
//  AppDelegate.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import UIKit
enum App {
    static var shared: UIApplication        { UIApplication.shared }
    static var delegate: AppDelegate        { shared.delegate as! AppDelegate }
    static var coordinator: Coordinator     { delegate.coordinator }
    static var window: UIWindow?            { delegate.window }
}
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var coordinator = Coordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let factory = Factory(coordinator: coordinator)
        coordinator.factory = factory
        coordinator.start()
        return true
    }

}

