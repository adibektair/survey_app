//
//  Router.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import Foundation
import UIKit

final class Coordinator {
    
    var factory: Factory?
    var navigation: UINavigationController?
    
    func start() {
        navigation = UINavigationController()
        if let vc = factory?.getWelcomeVC() {
            App.window?.rootViewController = navigation
            App.window?.makeKeyAndVisible()
            navigation?.setViewControllers([vc], animated: false)
        }
    }
    func openSurveyVC() {
        if let surveyVC = factory?.getSurveyVC() {
            navigation?.pushViewController(surveyVC, animated: true)
        }
    }
}
