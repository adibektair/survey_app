//
//  Question.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import Foundation

struct Question: Codable {
    var id: Int
    var question: String
    var submitted: Bool? = false
}
