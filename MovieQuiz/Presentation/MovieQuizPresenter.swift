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
    var correctAnswers: Int = 0
    private var questionFactory: QuestionFactoryProtocol?

    private weak var viewController: MovieQuizViewController?
   
    init(viewController: MovieQuizViewController) {
        self.viewController = viewController
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        questionFactory?.loadData()
        viewController.showLoadingIndicator()
    }
    
    func isLastQuestion() -> Bool {
        return currentQuestionIndex == questionsAmount - 1
    }
    
    func restartGame() {
        currentQuestionIndex = 0
        correctAnswers = 0
        questionFactory?.requestNextQuestion()
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
       didAnswer(isYes: true)
    }
    
    func noButtonClicked() {
        didAnswer(isYes: false)
    }
    
    func didRecieveNextQuestion(question: QuizQuestion?) {
        guard let question else { return }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    func showNextQuestionOrResults() {
        let statisticService = viewController?.statisticService
        
        if self.isLastQuestion() {
             statisticService?.store(correct: correctAnswers, total: questionsAmount)
            let text =
            """
            Ваш результат: \(correctAnswers)/\(questionsAmount)
            Количество сыграных квизов: \(statisticService?.gamesCount ?? 1)
            Рекорд: \(statisticService?.bestGame.correct ?? 0)/\(statisticService?.bestGame.total ?? 10) \(statisticService?.bestGame.date.dateTimeString ?? Date().dateTimeString)
            Cредняя точность: \(statisticService?.totalAccurancy ?? 0)%
            """
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            viewController?.show(quiz: viewModel)
        } else {
            switchToNextQuestion()
            questionFactory?.requestNextQuestion()
        }
    }
    
    func didAnswer(isCorrectAnswer: Bool) {
        correctAnswers += 1
    }
    
    private func didAnswer(isYes: Bool) {
        guard let currentQuestion else { return }
        
        let givenAnswer = isYes
        
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    
}

// MARK: - QuestionFactoryDelegate
extension MovieQuizPresenter: QuestionFactoryDelegate {
    
    func didLoadDataFromServer() {
        viewController?.hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        viewController?.showNetworkError(message: error.localizedDescription)
    }
}
