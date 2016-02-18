//
//  ViewController.swift
//  testRK
//
//  Created by William Morrison on 1/22/16.
//  Copyright © 2016 William Morrison. All rights reserved.
//

import UIKit
import ResearchKit

/* This is the file I want you to see. It has a simple survey UI built with research kit. It also gets the data from the survey in
the taskViewController function below.
*/

class ViewController: UIViewController {
    
    private var SurveyTask: ORKOrderedTask {
        //This is where the survey is actualy made
        
        var steps = [ORKStep]()
        //a step is like a single view or page in the survey
        
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")//create an instruction survey step
        instructionStep.title = "Emotion Test"
        instructionStep.text = "To what extent have you felt this way in the last 15 minutes?"
        steps += [instructionStep]//this essentialy adds the instructionStep to an array of steps called steps
        
        //create scale
        let textChoices : [ORKTextChoice] = [ORKTextChoice(text: "Not At All", value: 1), ORKTextChoice(text: "A Little", value: 2), ORKTextChoice(text: "Moderately", value: 3), ORKTextChoice(text: "Quite A Bit", value: 4), ORKTextChoice(text: "Extremely", value: 5)]
        
        let stepAnswerFormat = ORKAnswerFormat.textScaleAnswerFormatWithTextChoices(textChoices, defaultIndex: NSIntegerMax, vertical: false)
        
        let questionStep5 = ORKQuestionStep(identifier: "Afraid", title: "Afraid", answer: stepAnswerFormat)
        
        steps += [questionStep5]
        
        //module
        let questionStep4 = ORKQuestionStep(identifier: "Ashamed", title: "Ashamed", answer: stepAnswerFormat)
        
        steps += [questionStep4]
        //module
        
        //module
        let questionStepD = ORKQuestionStep(identifier: "Distressed", title: "Distressed", answer: stepAnswerFormat)
        
        steps += [questionStepD]
        //module
        
        //module
        let questionStep6 = ORKQuestionStep(identifier: "Guilty", title: "Guilty", answer: stepAnswerFormat)
        
        steps += [questionStep6]
        //module
        
        //module
        let questionStep7 = ORKQuestionStep(identifier: "Hostile", title: "Hostile", answer: stepAnswerFormat)
        
        steps += [questionStep7]
        //module
        
        //module
        let questionStep8 = ORKQuestionStep(identifier: "Irritable", title: "Irritable", answer: stepAnswerFormat)
        
        steps += [questionStep8]
        //module
        
        //module
        let questionStep9 = ORKQuestionStep(identifier: "Jittery", title: "Jittery", answer: stepAnswerFormat)
        
        steps += [questionStep9]
        //module
        
        //module
        let questionStep10 = ORKQuestionStep(identifier: "Nervous", title: "Nervous", answer: stepAnswerFormat)
        
        steps += [questionStep10]
        //module
        
        //module
        let questionStep11 = ORKQuestionStep(identifier: "Scared", title: "Scared", answer: stepAnswerFormat)
        
        steps += [questionStep11]
        //module
        
        //module
        let questionStep12 = ORKQuestionStep(identifier: "Upset", title: "Upset", answer: stepAnswerFormat)
        
        steps += [questionStep12]
        //module
        
        return ORKOrderedTask(identifier: "ShortLongNegativeAffectScale", steps: steps)//returns our new survey
    }
    
    private var SurveySelectTask: ORKNavigableOrderedTask {
        //This is where the survey is actualy made
        
        var steps = [ORKStep]()
        //a step is like a single view or page in the survey
        
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")//create an instruction survey step
        instructionStep.title = "Survey Selector"
        instructionStep.text = "Create the survey you want your subjects to use"
        steps += [instructionStep]//this essentialy adds the instructionStep to an array of steps called steps
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: "Mood", value: "mood"),
            ORKTextChoice(text: "Impulsivity", value: "impulsivity"),
        ]
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "SurveySelect1", title: "Survey Type Choices", answer: answerFormat)
        
        questionStep.text = "Select as many or as few as you desire"
        
        steps += [questionStep]
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices2 = [
            ORKTextChoice(text: "Long Negative affect scale", value: "longNegative"),
            ORKTextChoice(text: "Short Long Negative affect scale", value: "shortLongNegative"),
            ORKTextChoice(text: "Short Positive affect scale", value: "shortPositive")
        ]
        
        let answerFormat2 = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices2)
        
        let questionStep2 = ORKQuestionStep(identifier: "SurveySelect2", title: "Mood Choices", answer: answerFormat2)
        
        steps += [questionStep2]
        
        let textChoices3 = [
            ORKTextChoice(text: "Tomko MIS", value: "Tomko"),
            ORKTextChoice(text: "Trull momentary impulsivity measure based on UPPS ", value: "Trull"),
        ]
        
        let answerFormat3 = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices3)
        
        let questionStep3 = ORKQuestionStep(identifier: "SurveySelect3", title: "Impulsivity Choices", answer: answerFormat3)
        
        steps += [questionStep3]
        
        //
        
        let task = ORKNavigableOrderedTask(identifier: "T1", steps:steps)
        
        let inptResultSelector = ORKResultSelector(stepIdentifier: "SurveySelect1", resultIdentifier: "SurveySelect1")
        
        let predicateNotInpt = ORKResultPredicate.predicateForChoiceQuestionResultWithResultSelector(inptResultSelector, expectedAnswerValue: "impulsivity")
        let predicateNotInptRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(resultPredicate: predicateNotInpt, destinationStepIdentifier: "SurveySelect3")])
        
        task.setNavigationRule(predicateNotInptRule, forTriggerStepIdentifier: "SurveySelect1")
        
        return task
        //
        
    }
    
    @IBAction func surveySelelect(sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveySelectTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func cat(sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
        //this segues to the survey when I hit the button Survery
        //why did I call this function cat...I dont know
    }
    
    @IBAction func notify(sender: AnyObject) {
        
        /*let notificationSettings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)*/
        
        NSLog("hey")
        
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        if (settings!.types == .None) {
            let ac = UIAlertController(title: "Can't schedule", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            return
        }
        else{
            NSLog("yeah")
        }
        
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.alertBody = "Hi"
        notification.alertAction = "OK"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        //gets info
        let taskResult = taskViewController.result
        
        NSLog("--- %@",taskResult)//this outputs results to console
        
        //Handle results with taskViewController.result
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

