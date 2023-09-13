//
//  Modifier.swift
//  TicketLion_Consumer
//
//  Created by 남현정 on 2023/09/12.
//

import SwiftUI

struct textStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .foregroundColor(.gray)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
    }
}

