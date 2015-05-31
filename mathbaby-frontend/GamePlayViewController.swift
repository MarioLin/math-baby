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
    
    func copyState (setToCopy:UIQuestionSet) {
        self.frame = setToCopy.frame
        question.text = setToCopy.question.text
        for i in 0...buttons.count-1 {
            buttons[i].titleLabel?.text = setToCopy.buttons[i].titleLabel?.text
            buttons[i].setTitleColor(setToCopy.buttons[i].titleColorForState(UIControlState.Normal), forState: UIControlState.Normal)
        }
        self.hidden = setToCopy.hidden
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}

class GamePlayViewController: BaseViewController {

    var gameTime = 60.0
    var gameTimer:NSTimer?
    var score = 0
    
    var topYForButtonSet:CGFloat!
    var correctAnswer:String?
    
    var animationOngoing = false

    private var btnSetAnswers:UIQuestionSet!
    private var btnSetAnimations:UIQuestionSet!
    @IBOutlet weak var lbGametime:UILabel!
    @IBOutlet weak var lbScore:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topYForButtonSet = lbGametime.frame.origin.y + lbGametime.frame.size.height + 20
        var frame:CGRect = CGRectMake(0, topYForButtonSet, self.view.frame.width, self.view.frame.height - topYForButtonSet - 40)
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
        if (button.titleColorForState(UIControlState.Normal) == UIColor.darkTextColor() && !animationOngoing) {
            button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            if button.titleLabel?.text == correctAnswer {
                score += Constants.defaultValues.game.scoreRewardForCorrectAnswer
                gameTime += Constants.defaultValues.game.gametimeRewardForCorrectAnswer
                setUpNewQuestion(true)
            } else {
                gameTime += Constants.defaultValues.game.gametimePenaltyForWrongAnswer
            }
        }
    }
    
    /*
        Set up new question and play animation if animated is true
        This function will update self.correctAnswer as well
    */
    func setUpNewQuestion (animated: Bool) {
        self.animationOngoing = true
        let animationTime = animated ? 0.25 : 0
        btnSetAnimations.copyState(btnSetAnswers)
        btnSetAnswers.frame.origin = CGPointMake(self.view.frame.width, topYForButtonSet)
        btnSetAnswers.hidden = true
        let newQuestion = self.getNewQuestion()
        self.btnSetAnswers.question.text = convertQuestionToDisplayFormat(newQuestion)
        let answers = self.getPossibleAnswersForQuestion(newQuestion)
        var answersInString = newQuestion[1] == "/" ? answers.map{$0.doubleValue.formatString(".2")} : answers.map{$0.stringValue}
        self.correctAnswer = answersInString[0]
        answersInString.shuffle()
        for buttonIdx in 0...self.btnSetAnswers.buttons.count-1 {
            self.btnSetAnswers.buttons[buttonIdx].setTitleColor(UIColor.darkTextColor(), forState: UIControlState.Normal)
            self.btnSetAnswers.buttons[buttonIdx].setTitle(answersInString[buttonIdx], forState: UIControlState.Normal)
        }
        self.btnSetAnswers.hidden = false
        UIView.animateWithDuration(animationTime, animations: {
            self.btnSetAnimations.frame.origin = CGPointMake(-1.5*self.view.frame.width, self.topYForButtonSet)
            self.btnSetAnswers.frame.origin = CGPointMake(0, self.topYForButtonSet)
            }, completion: { completed in
                self.btnSetAnimations.hidden = true
                self.animationOngoing = false
        })
    }
    
    func getNewQuestion () -> String {
        return String(randomNumberMod(9) + 1) + Gametype.randomGameType(Singleton.gametype) + String(randomNumberMod(9) + 1)
    }
    
    func convertQuestionToDisplayFormat (var question:String) -> String {
        if question[1] == "*" {
            question = question.stringByReplacingOccurrencesOfString("*", withString: "x", options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
        question = question[0] + " " + question[1] + " " + question[2]
        return question
    }
    
    /* 
        return an array of answers for a particular question
        correct answer is at position 0 in the return array
    */
    func getPossibleAnswersForQuestion (var question: String) -> [NSNumber] {
        question = question + ".0"
        let answer = computeAnswerForQuestion (question)
        var answers = [answer]
        let operation = question[1]
        while answers.count < 4 {
            var newAnswer:NSNumber!
            switch operation {
            case "+", "-":
                newAnswer = answer.integerValue + randomPositiveNegativeOne() * (randomNumberMod(3) + 1)
            case "*":
                newAnswer = answer.integerValue + randomPositiveNegativeOne() * (randomNumberMod(20) + 1)
            case "/":
                newAnswer = answer.doubleValue + Double(randomPositiveNegativeOne()) * Double(randomNumberMod(9) + 1) / Double(randomNumberMod(10) + 11)
            default:
                fatalError("Malformed question for game")
            }
            if !contains(answers, newAnswer) {
                answers.append(newAnswer)
            }
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
        This function handles the transition to the view controller that shows game result and updates score records
    */
    func endGame () {
        gameTimer?.invalidate()
        gameTimer = nil
        let vc = Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GameResultViewController) as! GameResultViewController
        vc.gameResult = score
        Singleton.storeGameRecord(score: score, gametype: Singleton.gametype)
        Singleton.updateUserStatisticsForGametype(Singleton.gametype)
        self.navigationController?.pushViewControllerRetro(vc)
    }
    
}
