//
//  RoundedCorner.swift
//  SwiftInti
//
//  Created by Gonzalo Linares N on 1/02/24.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

#Preview {
    Rectangle()
        .fill(Color.red)
        .frame(width: 100, height: 100)
        .cornerRadius(16.0, corners: .topLeft)
}
