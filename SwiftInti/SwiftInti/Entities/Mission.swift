//
//  Mission.swift
//  SwiftInti
//
//  Created by Gonzalo Linares N on 8/01/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date? // let launchDate: String?
    let crew: [CrewRole]
    let description: String
}

extension Mission {
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
