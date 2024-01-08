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
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
