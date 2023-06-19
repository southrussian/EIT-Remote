//
//  View.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import SwiftUI

extension View {
    // Closing all active Keyboards
    func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func hAligh(_ alignment: Alignment)-> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
        
    }
    func vAligh(_ alignment: Alignment)-> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
}
