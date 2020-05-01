//
//  ContentView.swift
//  Moonshot
//
//  Created by Lance Kent Briones on 5/1/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Button(action: {
                let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Avenue",
                        "city": "Nashville"
                    }
                }
                """
                
                struct User: Codable{
                    var name: String
                    var address: Address
                }
                
                struct Address: Codable{
                    var street: String
                    var city: String
                }
                
                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                
                if let user = try? decoder.decode(User.self, from: data){
                    print(user.address.street)
                }
                
            }){
                Text("Decode JSON")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
