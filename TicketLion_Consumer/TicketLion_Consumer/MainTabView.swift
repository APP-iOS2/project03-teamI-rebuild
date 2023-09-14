//
//  MainTabView.swift
//  TicketLion_Comsumer
//
//  Created by 김종찬 on 2023/09/05.
//

import SwiftUI

struct MainTabView: View {
	
	@State private var tabIndex: Int = 0
	@State var isLoading: Bool = true
	
	@ObservedObject var userStore = UserStore()
	
	var body: some View {
		
		ZStack {
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
			
			if isLoading {
				launchScreenView.transition(.opacity).zIndex(1)
			}
		}
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
				withAnimation { isLoading.toggle() }
			})
		}
		
	}
}

extension MainTabView {
	
	var launchScreenView: some View {
		ZStack(alignment: .center) {
			LinearGradient(gradient: Gradient(colors: [Color("AnyButtonColor"), Color("Color")]),
						   startPoint: .top, endPoint: .bottom)
			.edgesIgnoringSafeArea(.all)
			VStack {
				Text("Ticket Lion")
					.font(.system(size: 55))
					.fontWeight(.black)
					.foregroundStyle(LinearGradient(
						colors: [Color("AnyButtonColor"),
								 Color("MainColor"),
								],
						startPoint: .leading,
						endPoint: .trailing
					))
			}
			
			
		}
		
	}
	
}

struct MainTabView_Previews: PreviewProvider {
	static var previews: some View {
		MainTabView()
	}
}
