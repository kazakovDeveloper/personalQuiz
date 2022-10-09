//
//  ResultViewController.swift
//  personalQuiz
//
//  Created by Kazakov Danil on 07.10.2022.
//

import UIKit



class ResultViewController: UIViewController {
    
    var controlAnswers: [Answer]!
    
    @IBOutlet var resultOutlet: UILabel!
    @IBOutlet var describeAnswer: UILabel!
    
    //Почему я не могу создать эту функцию вне метода вьюДидЛоад? Потому что контроллАнсвер инициализируется после загрузки вью? 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        func makeResultDicision(answers: [Answer]) {
            
            var result: [Animal: Int]! = [Animal.wolf: 0, Animal.dragon: 0, Animal.eagle:0, Animal.whale: 0]
            
            for controlAnswer in controlAnswers {
                switch controlAnswer.animal {
                case .wolf:
                    result[Animal.wolf]! += 1
                case .eagle:
                    result[Animal.eagle]! += 1
                case .dragon:
                    result[Animal.dragon]! += 1
                case .whale:
                    result[Animal.whale]! += 1
                }
            }
            
            let sortedByValueDictionary = result.sorted { $0.1 < $1.1 }
            
            if sortedByValueDictionary.last!.key == Animal.wolf {
                resultOutlet.text = String(Animal.wolf.rawValue)
                describeAnswer.text = Animal.wolf.definition
            } else if sortedByValueDictionary.last!.key == Animal.eagle {
                resultOutlet.text = String(Animal.eagle.rawValue)
                describeAnswer.text = Animal.eagle.definition
            } else if sortedByValueDictionary.last!.key == Animal.dragon {
                resultOutlet.text = String(Animal.dragon.rawValue)
                describeAnswer.text = Animal.dragon.definition
            } else if sortedByValueDictionary.last!.key == Animal.whale {
                resultOutlet.text = String(Animal.whale.rawValue)
                describeAnswer.text = Animal.whale.definition
            }
            
            
        }
        makeResultDicision(answers: controlAnswers)
        
        
    }
               
    
    @IBAction func doneBarButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
}
