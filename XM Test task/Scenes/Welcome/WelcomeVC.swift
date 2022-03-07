//
//  WelcomeVC.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import UIKit

class WelcomeVC: UIViewController, WelcomeViewProtocol, Nibbed {
    
    var viewModel: WelcomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onStartPressed(_ sender: Any) {
        viewModel?.startSurvey()
    }
}
