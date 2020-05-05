//
//  StatsStackViewCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 01.03.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class StatsStackViewCell: UIView {
    
    let answer: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let percentage: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let graph: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // behaviors
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.backgroundColor = .clear
        sv.axis = .horizontal
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBehaviors (behaviors: [Behavior?]) {
        
        for i in 0..<behaviors.count {
            
            if let behavior = behaviors[i] {
                
                let behaviorView = BehaviorView()
                let text = behavior.behavior
                let color = ColorPicker.getColor(behavior.color)
                behaviorView.setupContent(color: color, text: text!)
                stackView.addArrangedSubview(behaviorView)
            }
        }
    }
    
    func setupObjects (ans: String, perc: String, graphWidth: Float, color: UIColor, behaviors: [Behavior?]) {
        // input
        answer.text = ans
        percentage.text = perc
        graph.backgroundColor = color
        setupBehaviors(behaviors: behaviors)
                
        // add answer
        addSubview(answer)
        answer.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        answer.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        answer.widthAnchor.constraint(equalToConstant: 35).isActive = true
        answer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        answer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        // add graph
        addSubview(graph)
        graph.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        graph.leftAnchor.constraint(equalTo: answer.rightAnchor, constant: 5).isActive = true
        graph.widthAnchor.constraint(equalToConstant: CGFloat(graphWidth)).isActive = true
        graph.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        // add percentage
        addSubview(percentage)
        percentage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        percentage.leftAnchor.constraint(equalTo: graph.rightAnchor, constant: (graphWidth==0) ? 0 : 15).isActive = true
        percentage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        percentage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // add stackview
        addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
