//
//  WelcomeViewModel.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import Foundation

protocol WelcomeViewProtocol {
    var viewModel: WelcomeViewModelProtocol? { get set }
}

protocol WelcomeViewModelProtocol: AnyObject {
    func startSurvey()
}

class WelcomeViewModel: WelcomeViewModelProtocol {
    
    weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
    
    func startSurvey() {
        coordinator?.openSurveyVC()
    }
}
