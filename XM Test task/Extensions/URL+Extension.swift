//
//  URL+Extension.swift
//  XM Test task
//
//  Created by tair on 5.03.22.
//

import Foundation

extension URL {
    static let base = URL(string: "https://powerful-peak-54206.herokuapp.com")!
}

func / (url: URL, path: String) -> URL {
    return url.appendingPathComponent(path)
}
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
extension URLRequest {

    func withBody<E: Encodable>(_ model: E) -> URLRequest {
        var mutable = self
        mutable.httpMethod = HttpMethod.post.rawValue
        mutable.setBody(model)
        return mutable
    }

    mutating func setBody<E: Encodable>(_ model: E) {
        do {
            httpBody = try JSONEncoder().encode(model)
            setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            print("ERROR encoding model:\n\(model)")
        }
    }

}
