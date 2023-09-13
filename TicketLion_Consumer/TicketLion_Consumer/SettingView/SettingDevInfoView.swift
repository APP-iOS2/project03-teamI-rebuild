//
//  SettingDevInfoView.swift
//  TicketLion_Comsumer
//
//  Created by 이승준 on 2023/09/06.
//

import SwiftUI

struct SettingDevInfoView: View {
    
    @ObservedObject var devStore: DevStore = DevStore()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("PM")) {
                    ForEach(devStore.pm) { devs in
                        SettingDevInfoDetailView(name: devs.name, introduction: devs.introduction, imageURL: devs.imageURL, informationURL: devs.informationURL)
                    }
                }
                Section(header: Text("TEAM 소비자 1")) {
                    ForEach(devStore.consumer1) { devs in
                        SettingDevInfoDetailView(name: devs.name, introduction: devs.introduction, imageURL: devs.imageURL, informationURL: devs.informationURL)
                    }
                }
                Section(header: Text("TEAM 소비자 2")) {
                    ForEach(devStore.consumer2) { devs in
                        SettingDevInfoDetailView(name: devs.name, introduction: devs.introduction, imageURL: devs.imageURL, informationURL: devs.informationURL)
                    }
                }
                Section(header: Text("TEAM 소비자 3")) {
                    ForEach(devStore.consumer3) { devs in
                        SettingDevInfoDetailView(name: devs.name, introduction: devs.introduction, imageURL: devs.imageURL, informationURL: devs.informationURL)
                    }
                }
                Section(header: Text("TEAM 관리자")) {
                    ForEach(devStore.admin) { devs in
                        SettingDevInfoDetailView(name: devs.name, introduction: devs.introduction, imageURL: devs.imageURL, informationURL: devs.informationURL)
                    }
                }
            }
            .navigationBarTitle("개발자 정보")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingDevInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SettingDevInfoView()
    }
}
