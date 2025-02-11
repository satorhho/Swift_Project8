//
//  MissionView.swift
//  Moonshot
//
//  Created by Lance Kent Briones on 5/3/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember{
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical){
                VStack{
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)
                    
                    Text("Launch Date: " + self.mission.formattedLaunchDate)
                        .foregroundColor( self.mission.formattedLaunchDate == "N/A" ? .red : .blue)
                        .fontWeight(.heavy)
                        .font(.headline)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role){ crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)){
                            HStack{
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.primary, lineWidth: 2))
                                
                                VStack(alignment: .leading){
                                    (crewMember.role == "Commander" ?  Text(crewMember.astronaut.name).foregroundColor(.red) : Text(crewMember.astronaut.name))
                                        
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]){
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }){
                matches.append(CrewMember(role: member.role, astronaut: match))
            }
            else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: self.missions[0], astronauts: self.astronauts)
    }
}
