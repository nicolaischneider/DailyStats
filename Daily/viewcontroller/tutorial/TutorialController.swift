//
//  TutorialController.swift
//  Daily
//
//  Created by Nicolai Schneider on 06.05.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class TutorialController {
    
    var view: TutorialVC!
    
    var currentPage: Int!
    var slides: [(String,String)] = [
        ("icon_tutorial","Daily Stats is the easiest and fastest way to keep track of your daily life. All it takes is 30 to 45 seconds of your day."),
        ("question_tutorial","Create a number of questions that you want to pose yourself every day, like \"How productive did I feel?\" or \" How happy was I today?\". Your answers are stored and transformed into statistics."),
        ("behavior_tutorial","Create a set of typical actions or behaviors you might take, like \"drank alcohol\" or \"did exercise\". Daily Stats will find a correlation between your behaviors and your given answers, thus learning how your activties might influence your answers."),
        ("notification_tutorial","To remember to answer your questions Daily Stats can send you a reminder once a day. Under settings you can choose the exact time for your reminder. It's recommended to set the timer before bedtime."),
    ]
    
    init(view: TutorialVC) {
        self.view = view
        self.currentPage = 0
    }
    
    func dismissVC () {
        view.dismiss(animated: true, completion: nil)
    }
    
    func getNumberOfSlides () -> Int {
        return slides.count
    }
    
    func nextTutorialSlide () {
        currentPage += 1
        if currentPage == slides.count {
            dismissVC()
        } else {
            view.scrollToPage(currentPage)
        }
    }
    
    func getContent(atIndex index: Int) -> (UIImage, String) {
        let img = UIImage(named: slides[index].0)
        return (img!,slides[index].1)
    }
    
}
