//
//  SeminarInfoView.swift
//  TicketLion_Consumer
//
//  Created by 윤진영 on 2023/09/12.
//

import SwiftUI

struct SeminarInfoView: View {
	
	@EnvironmentObject var userStore: UserStore
	
	var seminar: Seminar
	
	var body: some View {
		VStack(alignment: .leading) {
			
			Grid(alignment: .topLeading) {
				GridRow {
					Text("세미나")
                        .modifier(textStyle())
					
					Text("\(seminar.name)")
				}
				.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
				
				
				GridRow {
					
					Text("진행날짜")
                        .modifier(textStyle())
					
					Text("\(seminar.startDateCreator(seminar.seminarStartDate)) ~ \(seminar.endDateCreator(seminar.seminarEndDate, seminar.seminarStartDate))")
				}
				.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
				
				GridRow {
					Text("진행시간")
                        .modifier(textStyle())
					
					Text("\(seminar.timeCreator(seminar.seminarStartDate)) ~ \(seminar.timeCreator(seminar.seminarEndDate))")
				}
				.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
				
				GridRow {
					Text("강연자")
                        .modifier(textStyle())
					
					Text("\(seminar.host)")
				}
				.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
				
				GridRow {
					Text("장소 ")
                        .modifier(textStyle())
					
					if let _ = seminar.location {//오프라인이면
						
						Text("\(seminar.location ?? "location -")")
					}
					else {
						
						Text("(온라인 진행)")
					}
				}
			}
			
		}
	}
}
struct SeminarInfoView_Previews: PreviewProvider {
	static var previews: some View {
		SeminarInfoView(seminar: Seminar.seminarsDummy[0])
	}
}
