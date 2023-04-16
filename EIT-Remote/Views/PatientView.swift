//
//  PatientView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 29.11.2022.
//

import SwiftUI

struct PatientView: View {
    var body: some View {
        VStack {
            HStack {
                Image("photo")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .foregroundColor(.clear)
                Spacer()
                VStack(alignment: .trailing, spacing: 10) {
                    Text("Kristen Lin")
                        .font(.title)
                        .multilineTextAlignment(.trailing)
                        .fontWeight(.medium)
                    Text("21 years")
                        .font(.headline)
                        .fontWeight(.light)
                    
                }
                
                
                
                
                    
            }
            .padding(.horizontal)
            HStack {
                Text("А")
            }
        }
        
    }
}

struct PatientView_Previews: PreviewProvider {
    static var previews: some View {
        PatientView()
    }
}
