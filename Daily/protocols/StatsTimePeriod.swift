//
//  StatsTimePeriod.swift
//  Daily
//
//  Created by Nicolai Schneider on 17.04.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

enum StatsTimePeriod {
    case allTime
    case last6Months
    case lastMonth
}

protocol StatsTimePeriodDelegate {
    func changeStatsTimePeriod (to: StatsTimePeriod)
}
