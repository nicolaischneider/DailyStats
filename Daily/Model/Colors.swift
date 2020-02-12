//
//  Colors.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

public enum Colors {
    // ??
    case yellow
    case red
    case green
    
    // quesions
    case lambsGreen
    case costalBlue
    case desertSand
    case coral
    case terracotta
    
    // buttons
    case moss // main
    case seashell // type selected
    case gray // type unslected
}

public class ColorPicker {
    public static func getColor (_ color: Colors) -> UIColor {
        switch color {
            case .green: return UIColor(red: 143/255, green: 185/255, blue: 168/255, alpha: 1.0)
            case .yellow: return UIColor(red: 255/255, green: 193/255, blue: 83/255, alpha: 1.0)
            case .red: return UIColor(red: 176/255, green: 95/255, blue: 109/255, alpha: 1.0)
            
            // questions
            case .lambsGreen: return UIColor(red: 142/255, green: 186/255, blue: 168/255, alpha: 1.0)
            case .costalBlue: return UIColor(red: 185/255, green: 205/255, blue: 202/255, alpha: 1.0)
            case .desertSand: return UIColor(red: 242/255, green: 220/255, blue: 203/255, alpha: 1.0)
            case .coral: return UIColor(red: 253/255, green: 172/255, blue: 138/255, alpha: 1.0)
            case .terracotta: return UIColor(red: 227/255, green: 130/255, blue: 81/255, alpha: 1.0)
            
            default: return UIColor.black
        }
    }
    
    public static func getButtonColors (_ color: Colors) -> UIColor {
        switch color {
            case .moss: return UIColor(red: 88/255, green: 128/255, blue: 104/255, alpha: 1.0)
            case .seashell: return UIColor(red: 229/255, green: 176/255, blue: 164/255, alpha: 1.0)
            case .gray: return UIColor(red: 145/255, green: 143/255, blue: 145/255, alpha: 1.0)
            default: return UIColor.black
        }
    }
}
