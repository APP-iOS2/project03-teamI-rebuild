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
    CategoryChipModel(isSelected: false, titleKey: "프론트엔드"),
    CategoryChipModel(isSelected: false, titleKey: "백엔드"),
    CategoryChipModel(isSelected: false, titleKey: "iOS"),
    CategoryChipModel(isSelected: false, titleKey: "안드로이드"),
    CategoryChipModel(isSelected: false, titleKey: "기타")
    ]
}
