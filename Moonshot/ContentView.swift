//
//  ContentView.swift
//  Moonshot
//
//  Created by Lance Kent Briones on 5/1/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var date_or_crew: Bool = false
    
    var body: some View {
        NavigationView{
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)){
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading){
                        Text(mission.displayName)
                            .font(.headline)
                        if self.date_or_crew {
                            ForEach(self.get_members(mission: mission)){
                                Text($0.name)
                                    .font(.caption)
                            }
                        }
                        else{
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.date_or_crew.toggle()
                }){
                    Text("\(self.date_or_crew ? "Launch Date" : "Members")")
                }
            )
        }
    }
    
    func get_members(mission: Mission) -> [Astronaut]{
        var crew_members = [Astronaut]()
        
        for crews in mission.crew{
            for astronaut in self.astronauts{
                if crews.name == astronaut.id{
                    crew_members.append(astronaut)
                }
            }
        }
        
        return crew_members
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
