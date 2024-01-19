//
//  ContentView.swift
//  SwiftInti
//
//  Created by Gonzalo Linares N on 2/01/24.
//

import SwiftUI

//View modifier para el corner radious
struct CustomRadius: ViewModifier {
    let oneCorner: Bool
    
    func body(content: Content) -> some View {
        if oneCorner {
            content
                .clipShape(
                    .rect(topLeadingRadius: .zero,
                                           bottomLeadingRadius: .zero,
                                           bottomTrailingRadius: .zero,
                                           topTrailingRadius: 20)
                    )
                .overlay(
                        UnevenRoundedRectangle(topLeadingRadius: .zero,
                                               bottomLeadingRadius: .zero,
                                               bottomTrailingRadius: .zero,
                                               topTrailingRadius: 20)
                        .stroke(.white)
                    )
        } else {
            content
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white)
                )
        }
    }
}

extension View {
    func customRadius(status: Bool) -> some View {
        modifier(CustomRadius(oneCorner: status))
    }
}

struct ContentView: View {
    // TODO: Change this to another part
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let cellCornerRadius: CGFloat = 20.0
    
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
                                //Celda usando Custom Modifier para el radio
                                CustomCell(imageName: missions[index].image,
                                           displayName: missions[index].displayName,
                                           launchDate: missions[index].formattedLaunchDate)
                                    .background(selectedSegment == .first ? cellBackgroundColor(index: index) : .darkBackground)
                                    .customRadius(status: selectedSegment == .first && index % 2 != 0)
                                
                                
                                //Celda usando funcs para hacer el set up del corner radius
                                CustomCell(imageName: missions[index].image,
                                           displayName: missions[index].displayName + "Copy",
                                           launchDate: missions[index].formattedLaunchDate)
                                .background(.blue)
                                .clipShape(
                                    cellClipShapeForm(index: index, segment: selectedSegment)
                                )
                                .overlay(
                                    cellClipShapeForm(index: index, segment: selectedSegment)
                                        .stroke(.white)
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
    
    func cellClipShapeForm(index: Int, segment: Segments) -> UnevenRoundedRectangle {
        let defaultCornerRadius = UnevenRoundedRectangle(topLeadingRadius: cellCornerRadius,
                                                         bottomLeadingRadius: cellCornerRadius,
                                                         bottomTrailingRadius: cellCornerRadius,
                                                         topTrailingRadius: cellCornerRadius)
        guard segment == .first else {
            return defaultCornerRadius
        }
        
        let customCornerRadius = index % 2 == 0 ? defaultCornerRadius :
                                                  UnevenRoundedRectangle(topLeadingRadius: .zero,
                                                                         bottomLeadingRadius: .zero,
                                                                         bottomTrailingRadius: .zero,
                                                                         topTrailingRadius: cellCornerRadius)
        
        return customCornerRadius
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
