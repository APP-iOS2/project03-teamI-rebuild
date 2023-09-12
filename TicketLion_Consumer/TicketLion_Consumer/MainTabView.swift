//
//  MainTabView.swift
//  TicketLion_Comsumer
//
//  Created by 김종찬 on 2023/09/05.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var tabIndex: Int = 0
	
	@ObservedObject var userStore = UserStore()
    
    var body: some View {
        TabView {
            SeminarListView()
                .tabItem {
                    Image(systemName: "list.star")
                    Text("세미나")
                }.tag(0)
            MySeminarView()
                .tabItem {
                    Image(systemName: "ticket")
                    Text("나의 세미나")
                }.tag(1)
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                }.tag(2)
        }
        .tint(Color("AnyButtonColor"))
		.environmentObject(userStore)
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
