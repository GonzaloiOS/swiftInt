//
//  Color-Theme.swift
//  SwiftInti
//
//  Created by Gonzalo Linares N on 8/01/24.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color { //Shape style the big class for Color. 
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
