//
//  ApiErrorMessage.swift
//  MovieQuiz
//
//  Created by Nikolay Kozlov on 18.06.2023.
//

import Foundation

struct ApiErrorMessage: LocalizedError {
    var errorDescription: String?
    
    init(_ errorDescription: String? = nil) {
        self.errorDescription = errorDescription
    }
}
