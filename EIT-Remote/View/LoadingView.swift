//
//  LoadingView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 19.12.2022.
//

import SwiftUI

struct LoadingView: View {
    @Binding var show: Bool
    var body: some View {
        ZStack {
            if show {
                Group {
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding(15)
                        .background(Color.theme.background, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: show)
    }
}

