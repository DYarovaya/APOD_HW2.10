//
//  Response.swift
//  APOD_HW2.10
//
//  Created by Дарья Яровая on 26.06.2021.
//

import Foundation

struct ResponseData: Decodable {
    let title: String
    let explanation: String
    let url: String
    let hdurl: String
    
    init(
        title: String,
        explanation: String,
        url: String,
        hdurl: String
    ) {
        self.title = title
        self.explanation = explanation
        self.url = url
        self.hdurl = hdurl
    }
}
