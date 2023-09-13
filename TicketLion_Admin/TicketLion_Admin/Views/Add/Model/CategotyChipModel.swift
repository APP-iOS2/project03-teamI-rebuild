//
//  CategotyChipModel.swift
//  TicketLion_Admin
//
//  Created by 나예슬 on 2023/09/06.
//

import Foundation
import SwiftUI

struct CategoryChipModel: Identifiable {
    var isSelected: Bool
    let id: UUID = UUID()
    let titleKey: String
}

class ChipsViewModel: ObservableObject {
    @Published var chipArray: [CategoryChipModel] = [
    CategoryChipModel(isSelected: false, titleKey: "Front-End"),
    CategoryChipModel(isSelected: false, titleKey: "Back-End"),
    CategoryChipModel(isSelected: false, titleKey: "iOS Dev"),
    CategoryChipModel(isSelected: false, titleKey: "Android Dev"),
    CategoryChipModel(isSelected: false, titleKey: "etc")
    ]
}
