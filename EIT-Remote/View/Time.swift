//
//  Time.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 07.06.2023.
//

import SwiftUI

struct Time: View {
    @State private var currentTime = Date()

        var body: some View {
            Text(currentTimeFormatted())
                .onAppear {
                    startTimer()
                }
        }

        func startTimer() {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                currentTime = Date()
            }
            timer.tolerance = 0.1
        }

        func currentTimeFormatted() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            return formatter.string(from: currentTime)
        }
}
