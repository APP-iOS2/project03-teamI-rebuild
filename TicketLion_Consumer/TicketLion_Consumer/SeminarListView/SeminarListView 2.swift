//
//  SeminarListView.swift
//  TicketLion_Comsumer
//
//  Created by 이재승 on 2023/09/06.
//
// Q. VStack 안에 List를 사용할 경우, 탭바가 뚫리는 이유?

import SwiftUI

struct SeminarListView: View {
    @StateObject var seminarStore: SeminarStore = SeminarStore()
    @EnvironmentObject var userStore: UserStore
    
    @State private var selectedCategory: Category = .FrontEnd
    @Namespace var animation
    
    @State private var search: String = ""
    
    @State var isShowingDetail: Bool = false
    @State var showingAlert = false
    
    @State var newSeminar: Seminar = Seminar.seminarsDummy[1]
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView(.horizontal, showsIndicators: false){
                seminarCategoryButton
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 2, trailing: 0))
                
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            
            ScrollView {
                //                Picker("Category", selection: $category) {
                //                    Text(Category.iOSDevelop.categoryName).tag(Category.iOSDevelop)
                //                    Text(Category.AndroidDevelop.categoryName).tag(Category.AndroidDevelop)
                //                    Text(Category.FrontEnd.categoryName).tag(Category.FrontEnd)
                //                    Text(Category.BackEnd.categoryName).tag(Category.BackEnd)
                //                }
                //                .pickerStyle(.segmented)
                //                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                SeminarListSubView(seminarStore: seminarStore, category: $selectedCategory, search: $search, showingAlert: $showingAlert) // 서브뷰
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("로그인후 이용해주세요"),
                      message: nil,
                      primaryButton: .default(Text("로그인 하기")) {
                    userStore.loginSheet = true
                    print("userStore.loginSheet : \(userStore.loginSheet)")
                    print("알럿 먹힘")
                },
                      secondaryButton: .cancel(Text("취소"))
                )
            }
            .navigationTitle("세미나 목록")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                seminarStore.fetchSeminar()
                userStore.fetchUserInfo()
            }
            .refreshable {
                seminarStore.fetchSeminar()
                userStore.fetchUserInfo()
            }
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: selectedCategory.categoryName == "etc." ? "그외 세미나를 찾아보세요.": "\(selectedCategory.categoryName) 세미나를 찾아보세요.")
            
        }
        
    }
}

extension SeminarListView {
    
    var seminarCategoryButton: some View {
        HStack {
            ForEach(Category.allCases, id: \.rawValue) { category in
                VStack {
                    if selectedCategory == category {
                        Text(category.categoryName)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .background(Color("AnyButtonColor"))
                            .cornerRadius(20)
                        
                    } else {
                        Text(category.categoryName)
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
    }
}

struct SeminarListView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			SeminarListView().environmentObject(UserStore())
		}
	}
}

