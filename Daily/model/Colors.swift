//
//  Colors.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

public enum Colors: Int, Codable {
    // quesions
    case lambsGreen
    case costalBlue
    case desertSand
    case coral
    case terracotta
    
    // behaviors
    case nineteesBlue
    case aquamarine
    case beige
    case goldenYellow
    case rustyOrange
    
    // buttons
    case moss // main
    case seashell // type selected
    case gray // type unslected
    case lightGray
    
    // default
    case defaultCol
}

public class ColorPicker {
    public static func getColor (_ color: Colors) -> UIColor {
        switch color {
            // questions
            case .lambsGreen: return UIColor(red: 142/255, green: 186/255, blue: 168/255, alpha: 1.0)
            case .costalBlue: return UIColor(red: 185/255, green: 205/255, blue: 202/255, alpha: 1.0)
            case .desertSand: return UIColor(red: 242/255, green: 220/255, blue: 203/255, alpha: 1.0)
            case .coral: return UIColor(red: 253/255, green: 172/255, blue: 138/255, alpha: 1.0)
            case .terracotta: return UIColor(red: 227/255, green: 130/255, blue: 81/255, alpha: 1.0)
            
            // unselected behavior
            case .lightGray: return UIColor(red: 235/255, green: 237/255, blue: 235/255, alpha: 1.0)
            
            // selected behaviors
            case .aquamarine: return UIColor(red: 140/255, green: 200/255, blue: 197/255, alpha: 1.0)
            case .nineteesBlue: return UIColor(red: 198/255, green: 219/255, blue: 209/255, alpha: 1.0)
            case .beige: return UIColor(red: 198/255, green: 168/255, blue: 127/255, alpha: 1.0)
            case .goldenYellow: return UIColor(red: 206/255, green: 164/255, blue: 78/255, alpha: 1.0)
            case .rustyOrange: return UIColor(red: 214/255, green: 142/255, blue: 79/255, alpha: 1.0)
            
            case .defaultCol: return UIColor.black
            
            // behaviors
            // ... to find
            
            default: return UIColor.black
        }
    }
    
    public static func getButtonColors (_ color: Colors) -> UIColor {
        switch color {
            case .moss: return UIColor(red: 88/255, green: 128/255, blue: 104/255, alpha: 1.0)
            case .seashell: return UIColor(red: 229/255, green: 176/255, blue: 164/255, alpha: 1.0)
            case .gray: return UIColor(red: 145/255, green: 143/255, blue: 145/255, alpha: 1.0)
            case .defaultCol: return UIColor.black
            
            default: return UIColor.black
        }
    }
}
