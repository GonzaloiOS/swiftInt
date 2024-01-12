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
    
    enum Segments: Int, CaseIterable {
        case first
        case second
        case third
        
        func name() -> String {
            switch self {
            case .first:
                "First"
            case .second:
                "Second"
            case .third:
                "Third"
            }
        }
    }
    
    @State private var selectedSegment: Segments = .first
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                Picker("", selection: $selectedSegment) {
                    ForEach(Segments.allCases, id: \.self) { item in
                        Text("\(item.name())")
                            .tag(item)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                LazyVGrid(columns: setupColumns()) {
                    ForEach(0..<missions.count, id: \.self) { index in
                        
                        NavigationLink { //The navigation here
                            MissionView(mission: missions[index], astronauts: astronauts)
                        } label: {
                            // celda de tamaño completo con esta misma custom cell.
                            // Color diferente a la derecha
                            VStack {
                                CustomCell(imageName: missions[index].image, displayName: missions[index].displayName, launchDate: missions[index].formattedLaunchDate)
                                    .background(selectedSegment == .first ? cellBackgroundColor(index: index) : .darkBackground)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.lightBackground)
                                    )
                                
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark) // TODO: Workaround for the title, always on dark mode.
        }
    }
    
    func cellBackgroundColor(index: Int) -> Color {
        let status = index % 2 == 0
        let color: Color = status ? .darkBackground : .red
        return color
    }
    
    func setupColumns() -> [GridItem] {
        switch selectedSegment {
        case .first:
            [GridItem(.adaptive(minimum: 150))]
        case .second:
            [GridItem(.flexible())] // Take 1
        case .third:
            [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
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
        //.background(.darkBackground)
    }
}

#Preview {
    ContentView()
}
