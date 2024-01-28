//
//  TextRow.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 1/28/24.
//

import SwiftUI

struct TextRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(value)
        }
    }
}

#Preview {
    TextRow(title: "Test Title", value: "Test Value")
}
