//
//  NetworkService.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import Foundation
import Combine

final class NetworkService {
    
    private let session: URLSession
    private var cancellable: AnyCancellable?
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getQuestions(completion: @escaping ([Question]) -> Void)  {
        cancellable = session.dataTaskPublisher(for: URL.base/"questions")
            .print()
            .tryMap { $0.data }
            .decode(type: [Question].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .sink { questions in
                completion(questions)
        }
    }

    func submit(_ answer: AnswerRequestModel, completion: @escaping BoolClosure) {
        let request = URLRequest(url: URL.base/"question/submit")
            .withBody(answer)
        cancellable = session.dataTaskPublisher(for: request)
            .print()
            .sink(receiveCompletion: { _ in }, receiveValue: { output in
                if let httpResponse = output.response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completion(true)
                        return
                    }
                }
                completion(false)
            })
    }
}
