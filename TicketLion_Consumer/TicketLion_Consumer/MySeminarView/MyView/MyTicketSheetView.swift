//
//  MyTicketSheetView.swift
//  TicketLion_Comsumer
//
//  Created by Ari on 2023/09/06.
//

import SwiftUI

struct MyTicketSheetView: View {
    
    @ObservedObject var mySeminarStore: MySeminarStore
	@EnvironmentObject var userStore: UserStore
    
    @State private var showingAlert = false
    @Binding var showingToast: Bool
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        VStack{
            VStack {
                ticketView
                    .onTapGesture {
                        isShowingSheet = false
                        mySeminarStore.navigationPath.append(mySeminarStore.selectedSeminar)
                    }
                    
                
                //QR
                Image("qrCode")
                    .resizable()
                    .frame(width: 270, height: 270)
                    .padding(5)
                    .background(Color(.systemGray5))
                Text("*입장시 직원에게 보여주세요.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
                
				if !userStore.canceledSeminars.contains(mySeminarStore.selectedSeminar.id) {
					// 예매취소 버튼
					HStack {
						Text("예매 취소")
					}
					.font(.title3)
					.underline()
					.frame(width: 100)
	//                .background(.red)
					.foregroundColor(.red)
					.cornerRadius(10)
					//                .underline()
					//                .foregroundColor(.red)
					//                .padding([.bottom, .trailing])
					.onTapGesture {
						showingAlert = true
						userStore.cancelSeminar(seminarID: mySeminarStore.selectedSeminar.id)
					}
				}
				
                
            }
            
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("예매 취소"),
                      message: Text("해당 세미나의 티켓 예매가 취소됩니다."),
                      primaryButton: .destructive(Text("확인"),action: {
                    showingToast.toggle()
                    isShowingSheet = false
                }), secondaryButton: .cancel(Text("취소")))
            }
            
        }
        
    }
    
}

extension MyTicketSheetView {
    
    var ticketView: some View {
        VStack {
            HStack {
                ZStack(alignment: .leading) {
                    HStack {
                        //세미나사진
						if mySeminarStore.selectedSeminar.seminarImage == "" {
							Image("TicketLion")
								.resizable()
								.frame(width: 160, height: 160)
								.opacity(0.2)
						} else {
							AsyncImage(url: URL(string: mySeminarStore.selectedSeminar.seminarImage)) { image in
								image.image?.resizable()
									.frame(width: 160, height: 160)
									.opacity(0.2)
							}
						}
						
                        
                        Spacer()
                        //티켓배경문구
                        VStack {
                            Spacer()
                            Text("Lion Ticket")
                                .foregroundStyle(LinearGradient(
                                    colors: [Color("PickerButtonColor"),
                                             Color("AnyButtonColor"),
                                             Color("MainColor"),
                                            ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )).opacity(0.6)
                                .fontDesign(.serif)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("\(mySeminarStore.selectedSeminar.name)")
                            .multilineTextAlignment(.leading)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("MainColor"))
                        Divider()
                        Spacer()
                        HStack {
                            VStack(alignment: .leading) {
                                Text("강연자: ")
                                Text("일시: ")
                                Text("시간: ")
                                Text("장소: ")
                            }
                            VStack(alignment: .leading) {
                                Text("\(mySeminarStore.selectedSeminar.host)")
////                                Text(mySeminarStore.selectedSeminar.registerDate)
//                                Text("\(timeCreator(time: mySeminarStore.selectedSeminar.registerRunTime)) ~ \(timeCreator(time: mySeminarStore.selectedSeminar.registerEndTime))")
                                Text(mySeminarStore.selectedSeminar.location ?? "온라인")
                            }
                            .font(.headline)
                        }
                        Spacer()
                    }.padding([.leading, .top])
                    
				}
                Spacer()
                VStack {
                    Image(systemName: "chevron.compact.right")
                }
                .frame(width: 30, height: 160)
                .background(Color("AnyButtonColor"))
                
            }
        }
        .frame(height: 160)
		.background(Color("AnyButtonColor").opacity(0.05))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("AnyButtonColor"), lineWidth: 2))
        .padding(10)
    }

}

func timeCreator(time: Double) -> String {
    let createdAt: Date = Date(timeIntervalSince1970: time)
    let fomatter: DateFormatter = DateFormatter()
    fomatter.dateFormat = "hh:mm a"
    
    return fomatter.string(from: createdAt)
}


struct MyTicketSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MyTicketSheetView(mySeminarStore: MySeminarStore(), showingToast: .constant(false), isShowingSheet: .constant(true))
    }
}

