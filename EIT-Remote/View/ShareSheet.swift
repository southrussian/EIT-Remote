//
//  ShareSheet.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 07.06.2023.
//

import Foundation
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let view = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return view
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
