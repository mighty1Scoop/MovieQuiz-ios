//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Nikolay Kozlov on 21.05.2023.
//

import UIKit

protocol AlertPresenterProtocol: AnyObject {
    func showAlert(_ model: AlertModel)
}

final class AlertPresenter: AlertPresenterProtocol {
    
    //MARK: - Private properties
    private weak var viewController: UIViewController?
    
    //MARK: - Initalizer
    init(delegate: UIViewController?) {
        self.viewController = delegate
    }
    
    //MARK: - Public methods
    func showAlert(_ model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        alert.view.accessibilityIdentifier = "Game Results"
        
        let action = UIAlertAction(
            title: model.buttonText,
            style: .default) { _ in
            model.completion()
        }
        
        alert.addAction(action)
        viewController?.present(alert, animated: true)
    }
}
