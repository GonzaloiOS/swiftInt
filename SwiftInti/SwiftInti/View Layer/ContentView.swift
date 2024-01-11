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
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    enum Segments: Int {
        case first
        case second
    }
    
    @State private var selectedSegment: Segments = .first
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                Picker("", selection: $selectedSegment) {
                    Text("First")
                        .tag(Segments.first)
                    Text("Second")
                        .tag(Segments.second)
                }
                .pickerStyle(.segmented)
                .padding()
                
                
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        
                        NavigationLink { //The navigation here
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            // celda de tamaño completo con esta misma custom cell.
                            // Color diferente a la derecha
                            CustomCell(imageName: mission.image, displayName: mission.displayName, launchDate: mission.formattedLaunchDate)
                                .background(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark) // TODO: Workaround for the title, always on darkmode.
        }
    }
}

struct CustomCell: View {
    
    let imageName: String
    let displayName: String
    let launchDate: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding()
            
            VStack(spacing: 6) {
                Text(displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(launchDate)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .background(.darkBackground)
    }
}

#Preview {
    ContentView()
}
