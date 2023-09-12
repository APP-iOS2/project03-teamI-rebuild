//
//  SeminarInfoView.swift
//  TicketLion_Consumer
//
//  Created by 윤진영 on 2023/09/12.
//

import SwiftUI

struct SeminarInfoView: View {
    
        var seminar: Seminar
        
        func startDateCreator(_ time: Double) -> String {
            let createdAt: Date = Date(timeIntervalSince1970: time)
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            
            return formatter.string(from: createdAt)
        }

        func timeCreator(_ time: Double) -> String {
            let createdAt: Date = Date(timeIntervalSince1970: time)
            let fomatter: DateFormatter = DateFormatter()
            fomatter.dateFormat = "hh:mm a"
            
            return fomatter.string(from: createdAt)
        }
        
        func dateCreator(_ time: Double) -> String {
            let createdAt: Date = Date(timeIntervalSince1970: time)
            let fomatter: DateFormatter = DateFormatter()
            fomatter.dateFormat = "yyyy년 MM월 dd일"
            
            return fomatter.string(from: createdAt)
        }
        func endDateCreator(_ time: Double, _ startDate: Double) -> String {
            let createdAt: Date = Date(timeIntervalSince1970: time)
            
            let yearFormatter: DateFormatter = DateFormatter()
            let formatter: DateFormatter = DateFormatter()
            
            
            yearFormatter.dateFormat = "yyyy"
            
            //start년도와 end년도가 같으면 end년도 출력안하기
            if yearFormatter.string(from: createdAt) == yearFormatter.string(from: Date(timeIntervalSince1970: startDate)) {
                formatter.dateFormat = "MM월 dd일"
            }else {
                formatter.dateFormat = "yyyy월 MM월 dd일"
            }
            
            return formatter.string(from: createdAt)
        }
        
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

                        Text("\(startDateCreator(seminar.registerStartDate)) ~ \(endDateCreator(seminar.registerEndDate, seminar.registerStartDate))")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    GridRow {
                        Text("진행시간")
                            .bold()
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))

                        Text("\(timeCreator(seminar.registerStartDate)) ~ \(timeCreator(seminar.registerEndDate))")
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
