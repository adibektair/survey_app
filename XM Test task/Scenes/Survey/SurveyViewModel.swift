//
//  SurveyViewModel.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import Foundation
import RxRelay

protocol SurveyViewProtocol {
    var viewModel: SurveyViewModelProtocol? { get set }
    func showNotification(with style: NotifiactionStyle)
}

protocol SurveyViewModelProtocol: AnyObject {
    var currentQuestion: BehaviorRelay<Question?> { get set }
    var submittedAnswers: BehaviorRelay<[Int]> { get set }
    var view: SurveyViewProtocol { get set }
    var questionsList: [Question]? { get set }
    func submit(_ answer: String)
    func nextQuestion()
    func previousQuestion()
}

final class SurveyViewModel: SurveyViewModelProtocol {
    
    var view: SurveyViewProtocol
    var questionsList: [Question]?
    var currentQuestion = BehaviorRelay<Question?>(value: nil)
    var submittedAnswers = BehaviorRelay<[Int]>(value: [])
    
    var currentIndex = 0 {
        didSet {
            if let questionsList = questionsList {
                currentQuestion.accept(questionsList[currentIndex])
            }
        }
    }
    private var networkService: NetworkService
    
    init(view: SurveyViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
        getQuestions()
    }
    
    func submit(_ answer: String) {
        guard let id = currentQuestion.value?.id,
              !submittedAnswers.value.contains(id) else {
            return
        }
        
        let model = AnswerRequestModel(answer: answer, id: id)
        networkService.submit(model) { [weak self] success in
            guard let `self` = self else { return }
            self.view.showNotification(with: success ? .success : .error)
            if success {
                var values = self.submittedAnswers.value
                if !values.contains(model.id) {
                    values.append(model.id)
                    self.submittedAnswers.accept(values)
                }
            }
        }
    }
    
    func nextQuestion() {
        guard let count = questionsList?.count,
              (currentIndex != count - 1) else {
            return
        }
        currentIndex += 1
    }
    
    func previousQuestion() {
        guard currentIndex != 0 else {
            return
        }
        currentIndex -= 1
    }
    
    private func getQuestions() {
        networkService.getQuestions { [weak self] list in
            self?.questionsList = list
            self?.currentQuestion.accept(list.first)
        }
    }
}
