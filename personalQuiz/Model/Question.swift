//
//  Question.swift
//  personalQuiz
//
//  Created by Kazakov Danil on 07.10.2022.
//

struct Question {
    let title: String
    let responseType: ResponseType
    let answers: [Answer]
    
    static func getQuestion() -> [Question] {
        [
            Question(
                title: "Что бы вы выбрали?",
                responseType: .single,
                answers: [
                    Answer(title: "Сходить в лес на пикник с друзьями", animal: .wolf),
                    Answer(title: "Поднятся в горы один", animal: .eagle),
                    Answer(title: "Поход в пещеры с гидом", animal: .dragon),
                    Answer(title: "Путешествие на корабле", animal: .whale)
                ]
            ),
            Question(
                title: "Какие качества вам присуще?",
                responseType: .multiple,
                answers: [
                    Answer(title: "Ловкость", animal: .wolf),
                    Answer(title: "Скорость", animal: .eagle),
                    Answer(title: "Сила", animal: .dragon),
                    Answer(title: "Мудрость", animal: .whale)
                ]
            ),
            Question(
                title: "Что вам больше нравится?",
                responseType: .ranged,
                answers: [
                    Answer(title: "Суша", animal: .wolf),
                    Answer(title: "Суша", animal: .eagle),
                    Answer(title: "Вода", animal: .dragon),
                    Answer(title: "Вода", animal: .whale)
                ]
            )
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Animal: Character {
    case wolf = "🐺"
    case eagle = "🦅"
    case dragon = "🐉"
    case whale = "🐋"
    
    var definition: String {
        switch self {
            
        case .wolf:
            return "Вы волк"
        case .eagle:
            return "Вы орёл"
        case .dragon:
            return "Вы дракон"
        case .whale:
            return "Вы кит"
        }
    }
}
