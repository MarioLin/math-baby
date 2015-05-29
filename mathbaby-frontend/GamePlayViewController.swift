//
//  GamePlayViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/26/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

private class UIQuestionSet:UIView {
    
    var question:UILabel!
    var buttons = [UIButton]()
    
    init (frame : CGRect, viewController: GamePlayViewController) {
        super.init(frame : frame)
        backgroundColor = UIColor.clearColor()
        
        question = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height/3))
        question.font = UIFont.systemFontStandard
        question.textAlignment = NSTextAlignment.Center
        question.backgroundColor = UIColor.clearColor()
        addSubview(question)
        
        buttons.append(UIButton(frame: CGRectMake(0, frame.height/3, frame.width/2, frame.height/3)))
        buttons.append(UIButton(frame: CGRectMake(frame.width/2, frame.height/3, frame.width/2, frame.height/3)))
        buttons.append(UIButton(frame: CGRectMake(0, 2*frame.height/3, frame.width/2, frame.height/3)))
        buttons.append(UIButton(frame: CGRectMake(frame.width/2, 2*frame.height/3, frame.width/2, frame.height/3)))
        for button in buttons {
            button.addTarget(viewController, action: Selector("btnAnswerTouchDown:"), forControlEvents: UIControlEvents.TouchUpInside)
            button.titleLabel?.font = UIFont.systemFontStandard
            button.titleLabel?.textAlignment = NSTextAlignment.Center
            button.backgroundColor = UIColor.clearColor()
            addSubview(button)
        }
        
        viewController.view.addSubview(self)
    }
    
    func copyText (setToCopy:UIQuestionSet) {
        question.text = setToCopy.question.text
        for i in 0...buttons.count-1 {
            buttons[i].titleLabel?.text = setToCopy.buttons[i].titleLabel?.text
            buttons[i].setTitleColor(setToCopy.buttons[i].titleColorForState(UIControlState.Normal), forState: UIControlState.Normal)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}

class GamePlayViewController: BaseViewController {

    var gameTime = 60.0
    var gameTimer:NSTimer?
    var score = 0
    
    var correctAnswer:String?

    private var btnSetAnswers:UIQuestionSet!
    private var btnSetAnimations:UIQuestionSet!
    @IBOutlet weak var lbGametime:UILabel!
    @IBOutlet weak var lbScore:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topY = lbGametime.frame.origin.y + lbGametime.frame.size.height + 20
        var frame:CGRect = CGRectMake(0, topY, self.view.frame.width, self.view.frame.height - topY - 40)
        btnSetAnswers = UIQuestionSet(frame: frame, viewController: self)
        btnSetAnswers.hidden = true
        btnSetAnimations = UIQuestionSet(frame: frame, viewController: self)
        btnSetAnimations.hidden = true
    }
    
    /* 
        set up new game, everytime the view controller is loaded
    */
    override func viewWillAppear(animated: Bool) {
        gameTime = Constants.defaultValues.game.gameTime
        score = Constants.defaultValues.game.score
        updateGameTimerGraphics()
        setUpNewQuestion(false)
    }
    
    override func viewDidAppear(animated: Bool) {
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("timerFire"), userInfo: nil, repeats: true)
        for buttonIdx in 0...btnSetAnswers.buttons.count-1 {
        }
    }
    
    @IBAction func btnBackTouchDown (AnyObject) {
        self.navigationController?.popToRootViewControllerRetro()
    }
    
    @IBAction func DEBUG_btnProceedTouchDown (AnyObject) {
        gameTimer?.invalidate()
        self.navigationController?.pushViewControllerRetro(Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GameResultViewController))
    }
    
    /*
        call when answer UIButton is pressed, score and gametime should be updated accordingly
    */
    func btnAnswerTouchDown (button: UIButton) {
        if (button.titleColorForState(UIControlState.Normal) == UIColor.darkTextColor()) {
            button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            if button.titleLabel?.text == correctAnswer {
                DLog("correct answer")
                score += Constants.defaultValues.game.scoreRewardForCorrectAnswer
                gameTime += Constants.defaultValues.game.gametimeRewardForCorrectAnswer
                setUpNewQuestion(false)
            } else {
                gameTime -= Constants.defaultValues.game.gametimePenaltyForWrongAnswer
                DLog(("wrong answer"))
            }
        }
    }
    
    func setUpNewQuestion (animated: Bool) {
        let animationTime = animated ? 0.25 : 0
        if !animated {
            let newQuestion = getNewQuestion()
            btnSetAnswers.question.text = newQuestion
            let answers = getPossibleAnswersForQuestion(newQuestion)
            var answersInString = newQuestion[1] == "/" ? answers.map{$0.doubleValue.formatString(".2")} : answers.map{$0.stringValue}
            correctAnswer = answersInString[0]
            answersInString.shuffle()
            for buttonIdx in 0...btnSetAnswers.buttons.count-1 {
                btnSetAnswers.buttons[buttonIdx].setTitleColor(UIColor.darkTextColor(), forState: UIControlState.Normal)
                btnSetAnswers.buttons[buttonIdx].setTitle(answersInString[buttonIdx], forState: UIControlState.Normal)
            }
            btnSetAnswers.hidden = false
        }
    }
    
    func getNewQuestion () -> String {
        return String(randomNumberMod(10)) + Gametype.randomGameType(Singleton.gametype) + String(randomNumberMod(10))
    }
    
    /* 
        return an array of answers for a particular question
        correct answer is at position 0 in the return array
    */
    func getPossibleAnswersForQuestion (var question: String) -> [NSNumber] {
        question = question + ".0"
        let answer = computeAnswerForQuestion (question)
        var answers = [NSNumber]()
        let operation = question[1]
        switch operation {
            case "+", "-":
                answers = [answer, 1, 2, 3]
            case "*":
                answers = [answer, 1, 2, 3]
            case "/":
                answers = [answer, 1, 2, 3]
            default:
                DLog("error!")
        }
        return answers
    }
    
    func computeAnswerForQuestion (question: String) -> NSNumber {
        return (NSExpression(format: question).expressionValueWithObject(nil, context: nil) as! NSNumber)
    }
    
    /* 
        call for each timer fire, and reduces remaining game time by 0.1s, updates game timer graphics
    */
    func timerFire () {
        gameTime -= 0.1
        updateGameTimerGraphics()
        if gameTime < 0.05 {
            endGame()
        }
    }
    
    /*
        This is called at each timer update
        All real time graphics update should be done here
    */
    func updateGameTimerGraphics() {
        lbGametime.text = gameTime.formatString(".1")
        lbScore.text = "\(score)"
    }
    
    /* 
        This function handles the transition to the view controller that shows game result
    */
    func endGame () {
        gameTimer?.invalidate()
        gameTimer = nil
        let vc = Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GameResultViewController) as! GameResultViewController
        vc.gameResult = score
        self.navigationController?.pushViewControllerRetro(vc)
    }
    
}
