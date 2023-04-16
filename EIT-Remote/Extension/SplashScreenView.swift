//
//  SplashScreenView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 07.01.2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                VStack {
                    VStack {
                        Image("Icon")
                            .resizable()
                            .frame(width: 130, height: 130)
                            .foregroundColor(.mint)
                        HStack {
                            Text("EIT Remote")
                            Image(systemName: "lungs.fill")
                        }
                        .foregroundColor(.mint)
                    }
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 1.1)) {}
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
