//
//  MainView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 24.05.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
