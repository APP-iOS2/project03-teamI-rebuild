//
//  MyReservationView.swift
//  TicketLion_Comsumer
//
//  Created by Muker on 2023/09/06.
//

import SwiftUI
import SimpleToast

struct MyReservationView: View {
    
    @ObservedObject var mySeminarStore: MySeminarStore
	@EnvironmentObject var userStore: UserStore
    
    @State private var selectedCategory: MyCategoryButton = .whole
    
    @State private var selectedSeminar = Seminar.TempSeminar
    
    let toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 2,
        animation: .easeInOut,
        modifierType: .slide
    )
    
    var body: some View {
        VStack {
            myCategoryButton
                .padding(.top, 3)
            
            ScrollView {
				// List
				MySeminarListView(mySeminarStore: mySeminarStore, seminarList: createSeminarList())
                
            }
			.simpleToast(isPresented: $mySeminarStore.showingToast, options: toastOptions) {
                HStack {
                       Image(systemName: "exclamationmark.triangle")
                       Text("해당 세미나의 티켓 예매가 취소 되었습니다.")
                   }
                   .padding(15)
                   .background(Color.brown.opacity(0.8))
                   .foregroundColor(Color.white)
                   .cornerRadius(14)
               }
        }
    }
	
	func createSeminarList() -> [Seminar] {
		switch selectedCategory {
		case .whole:
			return mySeminarStore.seminarList.filter {
				userStore.appliedSeminars.contains($0.id) || userStore.canceledSeminars.contains($0.id)
			}
		case .reservation:
			return mySeminarStore.seminarList.filter {
				userStore.appliedSeminars.contains($0.id)
			}
		case .cancel:
			return mySeminarStore.seminarList.filter {
				userStore.canceledSeminars.contains($0.id)
			}
		}
		
	}
}


extension MyReservationView {
    var myCategoryButton: some View {
        HStack {
            ForEach(MyCategoryButton.allCases, id: \.rawValue) { category in
                VStack {
                    if category == selectedCategory {
                        Text(category.title)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .background(Color("AnyButtonColor"))
                            .cornerRadius(20)
                            
                    } else {
                        Text(category.title)
                            .padding(.vertical, 4)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1.5)
                            )
                        
                    }
                }
                .onTapGesture {
                    withAnimation(Animation.default) {
                        self.selectedCategory = category
                        print(self.selectedCategory)
                    }
                }
            }
            .padding(.leading, 2)
            Spacer()
        }
        .padding(.leading)
		.padding(.bottom)
    }
}

struct MyReservationView_Previews: PreviewProvider {
    static var previews: some View {
        MyReservationView(mySeminarStore: MySeminarStore())
    }
}
