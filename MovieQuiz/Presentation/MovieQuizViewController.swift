import UIKit

final class MovieQuizViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var alertPresenter: AlertPresenterProtocol?
    var statisticService: StatisticService?
    private var presenter: MovieQuizPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 20
        presenter = MovieQuizPresenter(viewController: self)
        
        statisticService = StatisticServiceImplementation()
        alertPresenter = AlertPresenter(delegate: self)
        showLoadingIndicator()
    }
    
    

    
    // MARK: - Private funcs
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        let alert: AlertModel = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать ещё раз") { [weak self] in
                guard let self = self else { return }
                
                presenter?.restartGame()
            }
        alertPresenter?.showAlert(alert)
    }
    
    func showAnswerResult(isCorrect: Bool) {
        presenter?.didAnswer(isCorrectAnswer: isCorrect)
        
        imageView.layer.masksToBounds = true // 1
        imageView.layer.borderWidth = 8 // 2
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor // 3
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self else { return }
            self.presenter?.showNextQuestionOrResults()
            
            self.imageView.layer.borderColor = UIColor.clear.cgColor
            enableButtons()
        }
        
    }
    
    // метод вывода на экран вопроса, который принимает на вход вью модель вопроса и ничего не возвращает
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    // приватный метод для показа результатов раунда квиза
    // принимает вью модель QuizResultsViewModel и ничего не возвращает
    func show(quiz result: QuizResultsViewModel) {
        let alertModel = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: result.buttonText) { [weak self] in
                guard let self = self else { return }
                
                presenter?.restartGame()
            }
        
        alertPresenter?.showAlert(alertModel)
    }
    
    private func disableButtons() {
        noButton.isEnabled = false
        yesButton.isEnabled = false
    }
    
    private func enableButtons() {
        yesButton.isEnabled = true
        noButton.isEnabled = true
    }
    
    
    // MARK: - IBActions

    @IBAction private func yesButtonClicked(_ sender: Any) {
        presenter?.yesButtonClicked()
        disableButtons()
    }
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        presenter?.noButtonClicked()
        disableButtons()
    }
}
