//
//  MySeminarView.swift
//  TicketLion_Comsumer
//
//  Created by 김종찬 on 2023/09/05.
//

import SwiftUI

struct MySeminarView: View {
    
    @StateObject var mySeminarStore = MySeminarStore()
    
    @State private var selectedFilter: MyFilterBar = .reservation
    @Namespace var animation
    
    var body: some View {
        NavigationStack(path: $mySeminarStore.navigationPath) {
            VStack {
                
                    myFilterView
                        .padding(.top)
                    
                        VStack {
                            switch selectedFilter {
                            case .reservation: MyReservationView(mySeminarStore: mySeminarStore)
                            case .favorite: MyFavoriteView()
                            }
                        }
                    
                    Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("나의 세미나")
            .navigationDestination(for: Seminar.self) { seminar in
                SeminarDetailView(isShowingDetail: .constant(false), dummy: mySeminarStore.selectedSeminar)
                    .navigationBarBackButtonHidden(true)
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
