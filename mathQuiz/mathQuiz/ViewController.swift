//
//  ViewController.swift
//  mathQuiz
//
//  Created by Chloe Chung on 2023/06/20.
//

/**사칙연산 결과 OX 맞추기 게임 만들기
 
 한화면에 임의의 곱셈 계산 식이 나옵니다
 예1) 2 x 5 = 10
 예2) 3 x 10 = 27
 
 그 아래에는 O / X  버튼이 있습니다
 이 버튼을 누르면 화면 가장 아래(또는 가장 위)에 있는 다음의 내용에 반영됩니다
 예) 맞춤 3 틀림 23
 
 추가기능도 만들어봅시다
 예1) 곱셈 말고 다른 사칙연산들도 문제에 반영해봅시다
 예2) 맞춤/틀림 숫자 리셋하기
 예3) 최대 10개의 문제를 제시하고 끝나면 리셋하기만 가능
 예4) 맞춤/틀림 말하기로 알려주기 (오호!, 땡, 꽥, 앗!...)
 
 UIKit과 SwiftUI 모두로 도전해봅시다**/

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var right: String = "O"
    var countRight: Int = 0
    var countWrong: Int = 0
    
    let synthesizer = AVSpeechSynthesizer()
    
    let rightAnswerVoice: [String] = ["Awesome!", "Brilliant!", "Great job!"]
    let wrongAnswerVoice: [String] = ["Ooops!", "Try Again!", "Come on!"]
    
    var selectedIndex = 0
    
    var isInitialLoad: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        randomAddition()
    }
    
    
    
    
    // 1. 곱셈 계산 식 Label
    @IBOutlet weak var mathQuiz: UILabel!
    
    // 3. 정답 갯수 카운팅(변수)
    @IBOutlet weak var counting: UILabel!
    
    // 4. 결과 알려주기
    @IBOutlet weak var answerText: UILabel!
    
    // 7. 사칙연산 Mode 추가
    @IBOutlet weak var chooseMode: UISegmentedControl!
    
    
    // 8. 사칙연산 메서드 구현
    @IBAction func chooseModeAction(_ sender: UISegmentedControl!) {
        
        selectedIndex = sender.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            randomAddition()
        case 1:
            randomMinus()
        case 2:
            randomMultiply()
        case 3:
            randomDivide()
        default:
            break
        }
    }
    
    // imageView
    @IBOutlet weak var statusImage: UIImageView!
   // firstImage, rightImage, wrongImage
    
    
    
    // 6. RESET 버튼
    @IBAction func resetButton(_ sender: Any) {
        countRight = 0
        countWrong = 0
        answerText.text = "Shall we try again?"
        counting.text = "Right Answers : \(countRight)  / Wrong Answers : \(countWrong)"
    }
    
    
    // 2. O,X 버튼과 맞고 틀린 갯수 세어주기
    @IBAction func rightButton(_ sender: Any) {
        
        if right == "O" {
            answerText.text = "Awesome!🤩"
            countRight += 1
//            statusImage.image = "rightImage"
            speakRandomVoice(from: rightAnswerVoice) // 정답 읽어주기
        } else {
            answerText.text = "Ooops!🤪"
            countWrong += 1
//            statusImage.image = "wrongImage"
            speakRandomVoice(from: wrongAnswerVoice) // 오답 읽어주기
        }
        counting.text = "Right Answers : \(countRight)  / Wrong Answers : \(countWrong)"
        
//        loadInitialVoices()
        switch selectedIndex {
        case 0:
            randomAddition()
        case 1:
            randomMinus()
        case 2:
            randomMultiply()
        case 3:
            randomDivide()
        default:
            break
        }
    }
    
    @IBAction func wrongButton(_ sender: Any) {
        if right == "X" {
            answerText.text = "Ooops!🤪"
            countWrong += 1
            speakRandomVoice(from: wrongAnswerVoice) // 오답 읽어주기
        } else {
            answerText.text = "Awesome!🤩"
            countRight += 1
            speakRandomVoice(from: rightAnswerVoice) // 정답 읽어주기
        }
        counting.text = "Right Answers : \(countRight)  / Wrong Answers : \(countWrong)"
        
        
        switch selectedIndex {
        case 0:
            randomAddition()
        case 1:
            randomMinus()
        case 2:
            randomMultiply()
        case 3:
            randomDivide()
        default:
            break
        }
    }
    
    
    
    // 5. 랜덤으로 나오는 곱셈식
    func randomMultiply() {
        
        let firstNum: Int = Int.random(in: 1...10)
        let secondNum: Int = Int.random(in: 1...10)
        let bool: Bool = Bool.random()
        
        if bool == true {
            mathQuiz.text = "\(firstNum) X \(secondNum) = \(firstNum * secondNum)"
            right = "O"
            
            
        } else {
            mathQuiz.text = "\(firstNum) X \(secondNum) = \(Int.random(in: 1...100))"
            right = "X"
        }
        
        
        print("randomMultiply")
        
    }
    
    // 9.랜덤으로 나오는 덧셈식
    func randomAddition() {
        
        let firstNum: Int = Int.random(in: 1...10)
        let secondNum: Int = Int.random(in: 1...10)
        let bool: Bool = Bool.random()
        
        if bool == true {
            mathQuiz.text = "\(firstNum) + \(secondNum) = \(firstNum + secondNum)"
            right = "O"
            
        } else {
            mathQuiz.text = "\(firstNum) + \(secondNum) = \(Int.random(in: 1...100))"
            right = "X"
            
        }
        
        
        print("randomAddition")
        
    }
    
    
    
    // 10. 랜덤으로 나오는 뺄셈식
    func randomMinus() {
        
        let firstNum: Int = Int.random(in: 1...10)
        let secondNum: Int = Int.random(in: 1...10)
        let bool: Bool = Bool.random()
        
        if bool == true {
            mathQuiz.text = "\(max(firstNum, secondNum)) - \(min(firstNum, secondNum)) = \(max(firstNum, secondNum) - min(firstNum, secondNum))"
            right = "O"
            
            
        } else {
            mathQuiz.text = "\(max(firstNum, secondNum)) - \(min(firstNum, secondNum)) = \(Int.random(in: 1...100))"
            right = "X"
            
        }
        
        
        print("randomMinus")
        
    }
    
    
    
    // 11. 랜덤으로 나오는 나눗셈식
    func randomDivide() {
        
        let firstNum: Int = Int.random(in: 1...10)
        let secondNum: Int = Int.random(in: 1...10)
        let bool: Bool = Bool.random()
        
        if bool == true {
            mathQuiz.text = "\(max(firstNum, secondNum)) ÷ \(min(firstNum, secondNum)) = \(max(firstNum, secondNum) / min(firstNum, secondNum))"
            right = "O"
            
        } else {
            mathQuiz.text = "\(max(firstNum, secondNum)) ÷ \(min(firstNum, secondNum)) = \(Int.random(in: 0...10))"
            right = "X"
            
            
        }
        
        print("randomDivide")
    }
    
    
    
    // 12. 정답인지 알려주는 함수
    func speakAnswer(_ text: String?) {
        
        guard let text = text else { return }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        synthesizer.speak(utterance)
        
        print("speakAnswer")
        
    }
    
    func speakRandomVoice(from voices: [String]) {
        let randomIndex = Int.random(in: 0..<voices.count)
        let randomVoice = voices[randomIndex]
        speakAnswer(randomVoice)
        
        print("speakRandomVoice")
    }

}

