//
//  SurveyVC.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import UIKit
import RxSwift
import ToastViewSwift

class SurveyVC: UIViewController, Nibbed {

    @IBOutlet weak var questionsSubmittedLbl: UILabel!
    @IBOutlet weak var questionTextLbl: UILabel!
    @IBOutlet weak var answerTV: UITextView!
    
    var viewModel: SurveyViewModelProtocol?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()
    }

    @IBAction func onSubmitPressed(_ sender: Any) {
        if !answerTV.text.isEmpty {
            viewModel?.submit(answerTV.text)
        }
    }
    
    private func setObservers() {
        viewModel?.currentQuestion.subscribe(onNext: { [weak self] question in
            guard let `self` = self else {
                return
            }
            DispatchQueue.main.async {
                self.questionTextLbl.text = question?.question
            }
        }).disposed(by: bag)
        
        viewModel?.submittedAnswers.subscribe(onNext: { [weak self] ids in
            guard let `self` = self else {
                return
            }
            DispatchQueue.main.async {
                self.questionsSubmittedLbl.text = "Submitted answers \(ids.count)/\(self.viewModel?.questionsList?.count ?? 0)"
            }
        }).disposed(by: bag)
    }
    @IBAction func nextQuestionPressed(_ sender: Any) {
        viewModel?.nextQuestion()
        answerTV.text = ""
    }

    @IBAction func previousQuestionPressed(_ sender: Any) {
        viewModel?.previousQuestion()
        answerTV.text = ""
    }
}
extension SurveyVC: SurveyViewProtocol {
    func showNotification(with style: NotifiactionStyle) {
        let toast = Toast.text(style.rawValue)
        DispatchQueue.main.async {
            toast.show(haptic: .warning)
        }
    }
}
