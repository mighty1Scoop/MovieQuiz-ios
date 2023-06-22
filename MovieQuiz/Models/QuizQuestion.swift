//
//  QuizQuestion.swift
//  MovieQuiz
//
//  Created by Nikolay Kozlov on 11.05.2023.
//

import Foundation

struct QuizQuestion {
    // картинка фильма
    let image: Data
    // строка с вопросом о рейтинге фильма
    let text: String
    // булевое значение (true, false), правильный ответ на вопрос
    let correctAnswer: Bool
}
