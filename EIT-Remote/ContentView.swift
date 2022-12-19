//
//  ContentView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 29.11.2022.
//

import SwiftUI


struct ContentView: View {
    @AppStorage("log_status") var logstatus: Bool = false
    var body: some View {
        if logstatus {
            Text("Main view")
        } else {
            LoginView()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
