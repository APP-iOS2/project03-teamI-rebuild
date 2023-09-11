//
//  SettingDevInfoDetailView.swift
//  TicketLion_Comsumer
//
//  Created by J on 2023/09/06.
//

import SwiftUI

struct SettingDevInfoDetailView: View {
    
    var name: String
    var introduction: String
    var imageURL: String
    var informationURL: String
    
    @State var url: URL = URL(string: "https://appschool3-ios.github.io/iOS-XC-00.html")!
    @State var isShowingInformationView: Bool = false
    
    var body: some View {
        
        
        Button {
            url = URL(string: informationURL)!
            isShowingInformationView.toggle()
        } label: {
            HStack {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .cornerRadius(50)
                } placeholder: {
                    ProgressView()
                }
                .padding(.trailing)
                VStack(alignment: .leading) {
                    Text(name)
                    Text(introduction)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "chevron.forward")
            }
            
        }
        
        
        .sheet(isPresented: $isShowingInformationView) {
            SettingDevInformationView(url: $url)
        }
    }
}

struct SettingDevInfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingDevInfoDetailView(name: "김종찬", introduction: "여주 광대", imageURL: "https://cdn.discordapp.com/attachments/1143375923832422510/1148868698019467305/Patrick.jpeg", informationURL: "https://appschool3-ios.github.io/iOS-XC-00.html")
    }
}
