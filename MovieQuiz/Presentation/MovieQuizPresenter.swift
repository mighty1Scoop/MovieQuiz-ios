//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Nikolay Kozlov on 22.06.2023.
//

import UIKit

final class MovieQuizPresenter {
    private let questionsAmount: Int = 10
    private var currentQuestionIndex = 0
    var currentQuestion: QuizQuestion?
    
    weak var viewController: MovieQuizViewController?
    
    func isLastQuestion() -> Bool {
        return currentQuestionIndex == questionsAmount - 1
    }
    
    func resetQuestionIndex() {
        currentQuestionIndex = 0
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func amountQuestions() -> Int {
        return questionsAmount
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        let image = UIImage(data: model.image) ?? UIImage()
        let questionText = model.text
        let number = "\(currentQuestionIndex+1)/\(questionsAmount)"
        
        return QuizStepViewModel(image: image, question: questionText, questionNumber: number)
    }
    
   func yesButtonClicked() {
        guard let currentQuestion else { return }
        let givenAnswer = true
        
       viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    func noButtonClicked() {
        guard let currentQuestion else { return }
        let givenAnswer = false
        
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
}
