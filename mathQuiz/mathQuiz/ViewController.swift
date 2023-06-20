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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        randomMultiply()
    }
    
    
    
    
    // 1. 곱셈 계산 식 Label
    @IBOutlet weak var mathQuiz: UILabel!
    
    // 3. 정답 갯수 카운팅(변수)
    @IBOutlet weak var counting: UILabel!
    
    // 4. 결과 알려주기
    @IBOutlet weak var answerText: UILabel!
    
    
    
    // 5. RESET 버튼
    @IBAction func resetButton(_ sender: Any) {
        counting.text = "맞춘 갯수 : \(countRight)  / 틀린 갯수 : \(countWrong)"
        countRight = 0
        countWrong = 0
        answerText.text = "다시 시작해볼까요?"
    }
    
    
    // 2. O,X 버튼
    @IBAction func rightButton(_ sender: Any) {
        
        if right == "O" {
            answerText.text = "딩동댕~!"
            countRight += 1
        } else {
            answerText.text = "앗 틀렸습니다"
            countWrong += 1
        }
        counting.text = "맞춘 갯수 : \(countRight)  / 틀린 갯수 : \(countWrong)"
        randomMultiply()
    }
    
    @IBAction func wrongButton(_ sender: Any) {
        if right == "X" {
            answerText.text = "앗 틀렸습니다"
            countWrong += 1
        } else {
            answerText.text = "딩동댕~!"
            countRight += 1
        }
        counting.text = "맞춘 갯수 : \(countRight)  / 틀린 갯수 : \(countWrong)"
        randomMultiply()
    }
    
    
    
    // 5. 랜덤으로 나오는 곱셈
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
    }

}

