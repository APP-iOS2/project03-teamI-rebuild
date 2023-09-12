//
//  SeminarInfoView.swift
//  TicketLion_Consumer
//
//  Created by 윤진영 on 2023/09/12.
//

import SwiftUI

struct SeminarInfoView: View {
    
        var seminar: Seminar
        
        var body: some View {
            VStack(alignment: .leading) {
                
                Grid(alignment: .topLeading) {
                    GridRow {
                        Text("세미나")
                            .bold()
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                        
                        Text("\(seminar.name)")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))

                    
                    GridRow {
                        
                        Text("진행날짜")
                            .bold()
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))

                        Text("\(seminar.startDateCreator(seminar.registerStartDate)) ~ \(seminar.endDateCreator(seminar.registerEndDate, seminar.registerStartDate))")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    GridRow {
                        Text("진행시간")
                            .bold()
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))

                        Text("\(seminar.timeCreator(seminar.registerStartDate)) ~ \(seminar.timeCreator(seminar.registerEndDate))")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    GridRow {
                        Text("강연자")
                            .bold()
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                        
                        Text("\(seminar.host)")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))

                    GridRow {
                        Text("장소 ")
                            .bold()
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                        
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
