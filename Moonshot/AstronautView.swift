//
//  AstronautView.swift
//  Moonshot
//
//  Created by Lance Kent Briones on 5/3/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronaut_missions: [Mission]
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical){
                VStack{
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .layoutPriority(0)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
    
                }
                
                Text("Missions involved in: ")
                    .foregroundColor(.green)
                    .font(.headline)
                
                VStack(spacing: 10){
                    ForEach(self.astronaut_missions){ mission in
                        HStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            
                            Text(mission.displayName)
                                .foregroundColor(.black)
                                .fontWeight(.black)
                                .font(.callout)
                            
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
    }
    init(astronaut: Astronaut){
        self.astronaut = astronaut
        
        var mission_holder = [Mission]()
        
        for mission in missions{
            for crews in mission.crew{
                if self.astronaut.id == crews.name{
                    mission_holder.append(mission)
                }
            }
        }
        
        self.astronaut_missions = mission_holder
        
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: self.astronauts[0])
    }
}
