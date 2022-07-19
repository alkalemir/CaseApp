//
//  CustomDivider.swift
//  CaseApp
//
//  Created by Emir Alkal on 17.07.2022.
//

import SwiftUI

struct CustomDivider: View {
    let color: Color
    let width: CGFloat = 2
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
