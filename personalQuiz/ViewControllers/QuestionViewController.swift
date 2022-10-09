//
//  ViewController.swift
//  personalQuiz
//
//  Created by Kazakov Danil on 06.10.2022.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet var QuestionProgressView: UIProgressView!
    @IBOutlet var QuestionLabel: UILabel!
    
    
    @IBOutlet var SingleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    
    @IBOutlet var multiplyStackView: UIStackView!
    
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var switchesOutlet: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
        }
    }
    
    @IBOutlet var rangedLabels: [UILabel]!
    
    private let question = Question.getQuestion()
    private var answersChosen: [Answer] = []
    private var questionIndex = 0
    private var currentAnswers: [Answer] {
        question[questionIndex].answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        navigationItem.hidesBackButton = true
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.controlAnswers = answersChosen
    }

    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)
        
        nextQuestion()
    }
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(switchesOutlet, currentAnswers) {
                if multipleSwitch.isOn {
                    answersChosen.append(answer)
                }
        }
        nextQuestion()
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: UIButton) {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
}

// MARK: - Private methods
extension QuestionViewController {
    //Спрятать все элементы ЮАЙ
    private func updateUI() {
        for stackView in [SingleStackView, multiplyStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        //Получить текущий вопрос
        let currentQuestion = question[questionIndex]
        //устанавливаем текущий вопрос в лейб
        QuestionLabel.text = currentQuestion.title
        //Подсчитываем прогресс
        let totalProgress = Float(questionIndex) / Float(question.count)
        //Устанавливаем прогресс
        QuestionProgressView.setProgress(totalProgress, animated: true)
        //устанавливаем заголовок в навигейшен контроллерец
        title = "Вопрос № \(questionIndex + 1) из \(question.count)"
        
        showCurrentAnswers(for: currentQuestion.responseType)
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
            
        case .single: showingSingleStackView(with: currentAnswers)
        case .multiple: showingMultipleStackView(with: currentAnswers)
        case .ranged: showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showingSingleStackView(with answers: [Answer]) {
        SingleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    private func showingMultipleStackView(with answers: [Answer]) {
        multiplyStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < question.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "resultVC", sender: nil)
    }
    
}
