//
//  Factory.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import Foundation
import UIKit

final public class Factory {
    
    weak var coordinator: Coordinator?
    static var networkService: NetworkService {
        return NetworkService(session: URLSession(configuration: .default))
    }
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func getWelcomeVC() -> UIViewController {
        let welcomeVC = WelcomeVC.instantiate()
        let welcomeVM = WelcomeViewModel(coordinator: coordinator)
        welcomeVC.viewModel = welcomeVM
        return welcomeVC
    }

    func getSurveyVC() -> UIViewController {
        let surveyVC = SurveyVC.instantiate()
        let surveyVM = SurveyViewModel(view: surveyVC, networkService: Factory.networkService)
        surveyVC.viewModel = surveyVM
        return surveyVC
    }
}
