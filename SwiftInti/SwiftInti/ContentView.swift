//
//  ContentView.swift
//  SwiftInti
//
//  Created by Gonzalo Linares N on 2/01/24.
//

import SwiftUI

struct ContentView: View {
    // TODO: Change this to another part
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        Text("A: \(astronauts.count), M: \(missions.count)")
            .padding()
    }
}

#Preview {
    ContentView()
}
