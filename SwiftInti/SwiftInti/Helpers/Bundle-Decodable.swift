//
//  Bundle-Decodable.swift
//  SwiftInti
//
//  Created by Gonzalo Linares N on 8/01/24.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T { // T: Type whatever, T: Codable (constrain for that)
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle") // TODO: Improve handling errors
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}
