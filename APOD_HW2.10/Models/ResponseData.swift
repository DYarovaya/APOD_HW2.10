//
//  Response.swift
//  APOD_HW2.10
//
//  Created by Дарья Яровая on 26.06.2021.
//

import Foundation

struct ResponseData: Decodable {
    let date: String
    let media_type: String
    let service_version: String
    let title: String
    let explanation: String
    let url: String
    let hdurl: String
    
    init(
        date: String,
        media_type: String,
        service_version: String,
        title: String,
        explanation: String,
        url: String,
        hdurl: String
    ) {
        self.date = date
        self.media_type = media_type
        self.service_version = service_version
        self.title = title
        self.explanation = explanation
        self.url = url
        self.hdurl = hdurl
    }
}
