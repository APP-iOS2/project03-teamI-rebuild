//
//  MySeminarListView.swift
//  TicketLion_Consumer
//
//  Created by Muker on 2023/09/13.
//

import SwiftUI

struct MySeminarListView: View {
	
	@ObservedObject var mySeminarStore: MySeminarStore
	@EnvironmentObject var userStore: UserStore
	@State private var starChecker = false
	@State private var isShowingSheet = false
	
	var seminarList: [Seminar]
	
	var body: some View {
		ForEach(seminarList, id: \.id) { seminar in
			
			Button {
				mySeminarStore.isShowingSheet = true
				mySeminarStore.selectedSeminar = seminar
			} label: {
				ZStack {

					VStack(alignment: .leading) {
						HStack(alignment: .top) {
							myListTileLabel(title: seminar.name)
							Spacer()
							myListfavoriteOnOffBtn(seminarID: seminar.id)
						}
						.bold()
						.font(.callout)
						
						VStack {
							HStack(alignment: .top) {
								if seminar.seminarImage == "" {
									Image("TicketLion")
										.resizable()
										.frame(width: 100, height: 100)
										.aspectRatio(contentMode: .fit)
								} else {
									AsyncImage(url: URL(string: seminar.seminarImage)) { phase in
										if let image = phase.image {
											image
										} else if phase.error != nil { // 에러 있을때
											Image("TicketLion")
												.resizable()
												.frame(width: 100, height: 100)
												.aspectRatio(contentMode: .fit)
										} else { // placeholder
											Image("TicketLion")
												.resizable()
												.frame(width: 100, height: 100)
												.aspectRatio(contentMode: .fit)
										}
									}
								}
								
								Spacer()
								
								VStack(alignment: .leading) { // 세미나 디테일
									Group {
										Text("강연자 : \(seminar.host)")
										Text("장소 : \(seminar.location ?? "location -")")
										Text("날짜 : \(seminar.startDateCreator(seminar.registerStartDate)) 부터")
										Text("시간 : \(seminar.timeCreator( seminar.registerStartDate)) ~ \(seminar.timeCreator( seminar.registerEndDate))")
									}
									.padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
									.foregroundColor(.black)
									.font(.footnote)
								}
								
								
							}
						}
					} // VStack 끝
					.padding()
					.background(userStore.canceledSeminars.contains(seminar.id) ? Color(.systemGray3) : Color("Color"))
					.cornerRadius(20)
					.padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
					
					if userStore.canceledSeminars.contains(seminar.id) {
						Text("예매취소")
							.font(.title)
							.fontWeight(.black)
							.foregroundColor(.white)
							.padding()
							.padding(.horizontal)
							.background(Color("MainColor"))
							.cornerRadius(10)
					}
					
				}
				
				
			} // 라벨 끝
			.sheet(isPresented: $mySeminarStore.isShowingSheet) {
				MyTicketSheetView(mySeminarStore: mySeminarStore,
								  showingToast: $mySeminarStore.showingToast,
								  isShowingSheet: $mySeminarStore.isShowingSheet
				)
				.presentationDetents([.height(570)])
				.presentationDragIndicator(.visible)
			}
		}
	}
}

extension MySeminarListView {
	
	func myListTileLabel(title: String) -> some View {
		Text(title) // 메인 타이틀
			.foregroundColor(.black)
			.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
	}
	
	func myListfavoriteOnOffBtn(seminarID: String) -> some View {
		Button { // 즐겨찾기 버튼
			// User, favoriteSeminar에 저장
			// 저장 후 User의 favoriteSeminar 배열에 해당 Seminar가 있으면 즐겨찾기 버튼에 불이 들어와야한다.
			
			if userStore.favoriteSeminars.firstIndex(of: "\(seminarID)") != nil {
				// 즐겨찾기 없애기
				userStore.removeFavoriteSeminar(seminarID: seminarID)
				print("\(userStore.favoriteSeminars)")
			} else {
				// 즐겨찾기 넣기
				userStore.addFavoriteSeminar(seminarID: seminarID)
				print("\(userStore.favoriteSeminars)")
			}
		} label: {
			
			Image(systemName: userStore.favoriteSeminars.contains(seminarID) ? "star.fill" : "star")
				.foregroundColor(userStore.favoriteSeminars.contains(seminarID) ? Color("AnyButtonColor") : .gray)
		}
	}
	
	
}

struct MySeminarListView_Previews: PreviewProvider {
	static var previews: some View {
		MySeminarListView(mySeminarStore: MySeminarStore(), seminarList: Seminar.seminarsDummy)
	}
}
