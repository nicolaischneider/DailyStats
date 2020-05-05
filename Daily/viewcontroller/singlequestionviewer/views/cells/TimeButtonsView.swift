//
//  timeButtonsView.swift
//  Daily
//
//  Created by Nicolai Schneider on 17.04.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class TimeButtonsView: UIView {
    
    let buttonText: UIButton = {
        let button = UIButton()
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var statsTime: StatsTimePeriod!
    
    var delegate: StatsTimePeriodDelegate!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        setupObjects()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonTitle (titleString: String, active: Bool, timePeriod: StatsTimePeriod) {
        buttonText.setTitle(titleString, for: .normal)
        makeButtonActive(active)
        statsTime = timePeriod
    }
    
    func makeButtonActive (_ active: Bool) {
        if active { buttonText.setTitleColor(.black, for: .normal) }
        else { buttonText.setTitleColor(.gray, for: .normal) }
    }
    
    @objc func buttonPressed () {
        delegate.changeStatsTimePeriod(to: statsTime)
    }
    
    private func setupObjects () {
        buttonText.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        addSubview(buttonText)
        buttonText.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        buttonText.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        buttonText.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        buttonText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

}
