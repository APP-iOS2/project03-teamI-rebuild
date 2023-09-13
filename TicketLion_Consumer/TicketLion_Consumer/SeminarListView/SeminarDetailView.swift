//
//  SeminarDetailView.swift
//  TicketLion_Comsumer
//
//  Created by 남현정 on 2023/09/06.
//

import SwiftUI

struct SeminarDetailView: View {
	
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var userStore: UserStore
	@Binding var isShowingDetail: Bool
	
	@Binding var seminar: Seminar
	
	///하단 신청 버튼 ( 원래.contains("\(dummy.id)") )
	private var attendButtonText: String {
		User.usersDummy[0].appliedSeminars .contains("1") ? "신청하기 " : "이미 신청한 세미나입니다"
	}
	private var attendButtonColor: Color {
		User.usersDummy[0].appliedSeminars .contains("1") ? Color("AnyButtonColor") : .gray
	}
	private var attendButtonDisabled: Bool {
		User.usersDummy[0].appliedSeminars .contains("1") ? false : true
	}
	
	///모집중, 모집마감
	private var recruiteText: String {
		seminar.closingStatus ? "모집마감" : "모집중"
	}
	private var recruiteColor: Color {
		seminar.closingStatus ? .red : .blue
	}
	
	var body: some View {
		VStack {
			ScrollView {
				
				VStack {
					ZStack {
						
						if seminar.seminarImage == "" {
							Image("TicketLion")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(maxWidth: 270)
								.padding(.bottom, 10)
						} else {
							AsyncImage(url: URL(string: seminar.seminarImage)) { image in
								image
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(maxWidth: 270)
								
							} placeholder: {
								ProgressView()
							}.padding(.bottom, 10)
						}
						
						
						
						
						//모집마감 여부 눈에 띄면 좋을 것 같아서 추가
						Text(" \(recruiteText) ")
							.foregroundColor(recruiteColor)
							.border(recruiteColor)
							.background(.white)
							.frame(
								maxWidth: 270,
								maxHeight: .infinity,
								alignment: .topLeading)
						
						
					}
					
					Divider()
					
					VStack(alignment: .leading) {
						Text("세미나")
							.font(.title3)
							.bold()
							.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
						
						HStack {
							SeminarInfoView(seminar: seminar)
							Spacer()
						}
					}
					.padding()
					
					
				}
				
				Divider()
				
				//MARK: 행사소개
				VStack(alignment: .leading) {
					Text("상세 소개")
						.font(.title3)
						.bold()
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
					
					Grid(alignment: .topLeading) {
						GridRow {
							
							Text("상세 정보")
								.modifier(textStyle())
							
							
							Text("\(seminar.details)")
						}
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
						
						GridRow {
							Text("모집 인원")
								.modifier(textStyle())
							
							Text("\(seminar.maximumUserNumber)")
						}
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
						
						GridRow {
							Text("모집 기간")
								.modifier(textStyle())
							
							
							Text("\(seminar.registerStartDate)")
						}
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
						
						GridRow {
							Text("진행 날짜")
								.modifier(textStyle())
							
							Text("\(seminar.startDateCreator(seminar.registerStartDate)) ~ \(seminar.endDateCreator(seminar.registerEndDate, seminar.registerStartDate))")
						}
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
						
						GridRow {
							Text("진행 시간")
								.modifier(textStyle())
							
							Text("\(seminar.timeCreator(seminar.registerStartDate)) ~ \(seminar.timeCreator(seminar.registerEndDate))")
						}
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
						
						GridRow {
							Text("장소")
								.modifier(textStyle())
							
							if let _ = seminar.location { //오프라인이면
								
								Text("\(seminar.location ?? "location -")")
								
								
							}else {
								
								Text("(온라인 진행)")
									.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
								
							}
						}
					}
					if let _ = seminar.location {
						
						SeminarDetailMapView(seminar: seminar)
						
					}
					
				}
				.padding()
				
				Spacer()
				
				
			}
			.navigationTitle("\(seminar.name)")
			.navigationBarTitleDisplayMode(.inline)
			
			
			//MARK: 신청버튼
			NavigationLink {
				SeminarAttendView(seminar: $seminar, user: User.usersDummy[0], isShowingDetail: $isShowingDetail)
			} label: {
				Text(attendButtonText)
				//                    .frame(maxWidth: .infinity)
					.font(.title2.bold())
			}
			.frame(width: 380,height: 60)
			.foregroundColor(.white)
			.background(attendButtonColor)
			.cornerRadius(5)
			.disabled(attendButtonDisabled)
			.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
			
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button {
					//                    isShowingDetail = false
					dismiss()
				} label: {
					Image(systemName: "chevron.backward")
						.foregroundColor(.orange)
				}
				
			}
		}
		
	}
	
}


struct SeminarDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			SeminarDetailView(isShowingDetail: .constant(true), seminar: .constant(Seminar.seminarsDummy[1]))
			
		}
	}
}
