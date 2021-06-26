//
//  DateFormatter.swift
//  APOD_HW2.10
//
//  Created by Дарья Яровая on 26.06.2021.
//

import Foundation

class CustomDateFormatter {
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
}
