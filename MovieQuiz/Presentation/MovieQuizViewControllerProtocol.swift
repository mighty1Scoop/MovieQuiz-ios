//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Nikolay Kozlov on 22.06.2023.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrect: Bool)
    func clearImageBorder()
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
    
    func changeButtonsActivity(enabled: Bool)
    
}
