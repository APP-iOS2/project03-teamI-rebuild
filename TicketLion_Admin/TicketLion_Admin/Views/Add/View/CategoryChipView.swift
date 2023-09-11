//
//  CategoryChipView.swift
//  TicketLion_Admin
//
//  Created by 나예슬 on 2023/09/06.
//

import SwiftUI

struct CategoryChipView: View {
    
    //let systemImage: String
//    let titleKey: LocalizedStringKey
     @Binding var CategoryChipModel : CategoryChipModel
    var body: some View {
        HStack(spacing: 4) {
                //Image.init(systemName: systemImage).font(.body)
            Text(CategoryChipModel.titleKey).font(.body).lineLimit(1)
            }
            .padding(.vertical, 4)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .foregroundColor(CategoryChipModel.isSelected ? .white : .blue)
            .background(CategoryChipModel.isSelected ? Color.blue : Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 1.5)
                
            ).onTapGesture {
                CategoryChipModel.isSelected.toggle()
            }
            }
}
struct CategoryChipView_Previews: PreviewProvider {
    @State static var categoryChipModel = CategoryChipModel(isSelected: false, titleKey: "iOS")
    
    static var previews: some View {
        CategoryChipView(CategoryChipModel: $categoryChipModel)
    }
}
