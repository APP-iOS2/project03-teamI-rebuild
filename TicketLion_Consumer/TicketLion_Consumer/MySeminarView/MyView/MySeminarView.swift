//
//  MySeminarView.swift
//  TicketLion_Comsumer
//
//  Created by 김종찬 on 2023/09/05.
//

import SwiftUI

struct MySeminarView: View {
    
    @StateObject var mySeminarStore = MySeminarStore()
	@EnvironmentObject var userStore: UserStore
    
    @State private var selectedFilter: MyFilterBar = .reservation
    @Namespace var animation
    
    var body: some View {
        NavigationStack(path: $mySeminarStore.navigationPath) {
			if userStore.currentUser == nil {
				VStack {
					Text("로그인하시면")
					HStack {
						Text("나의 세미나").fontWeight(.bold).foregroundColor(Color("AnyButtonColor"))
						Text("를 이용할 수 있습니다.")
					}.padding(.bottom, 40)
					
					
					Button {
						userStore.loginSheet = true
					} label: {
						Text("로그인 하기")
							.font(.title2)
							.foregroundColor(.white)
							.padding()
							.padding(.horizontal)
							.background(Color("AnyButtonColor"))
							.cornerRadius(10)
					}

				}
			} else {
				VStack {
					
					myFilterView
						.padding(.top)
					
					VStack {
						
						switch selectedFilter {
						case .reservation: MyReservationView(mySeminarStore: mySeminarStore)
								.onAppear {
									mySeminarStore.fetchSeminar()
								}
						case .favorite: MyFavoriteView(mySeminarStore: mySeminarStore)
						}
					}
					
					Spacer()
				}
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle("나의 세미나")
				.navigationDestination(for: Seminar.self) { seminar in
						SeminarDetailView(isShowingDetail: $mySeminarStore.isShowingDetailSeminar, seminar: $mySeminarStore.selectedSeminar)
							.navigationBarBackButtonHidden(true)
				}
				
			}
        }
		.onAppear {
			userStore.fetchUserInfo()
		}
		.sheet(isPresented: $userStore.loginSheet) {
			NavigationStack {
				SettingLoginView()
			}
		}
    
    }//body
}//MySeminarView

extension MySeminarView {
    
    var myFilterView: some View {
        HStack {
            ForEach(MyFilterBar.allCases, id: \.rawValue) { bar in
                
                VStack {
                    Text(bar.title)
                        .font(.title3)
                        .fontWeight(selectedFilter == bar ? .bold : .regular)
                        .foregroundColor(selectedFilter == bar ? .orange : .black)
                    
                    if selectedFilter == bar {
                        Capsule()
                            .foregroundColor(.orange)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(Animation.default) {
                        self.selectedFilter = bar
                        print(self.selectedFilter)
                    }
                }
            }
        }
    }
    
}

struct MySeminarView_Previews: PreviewProvider {
    static var previews: some View {
        MySeminarView()
    }
}
