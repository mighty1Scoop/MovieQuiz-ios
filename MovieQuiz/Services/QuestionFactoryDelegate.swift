//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Nikolay Kozlov on 21.05.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didRecieveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
