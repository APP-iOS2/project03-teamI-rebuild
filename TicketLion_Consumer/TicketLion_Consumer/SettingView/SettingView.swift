//
//  SettingView.swift
//  TicketLion_Comsumer
//
//  Created by 김종찬 on 2023/09/05.
//

import SwiftUI

struct SettingView: View {
    @State private var isToggleAutomaticLogin: Bool = false
    @State private var isLoggedinUser: Bool = true
    @State private var isShowingTermsView: Bool = false
    @State private var isLogoutAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                if isLoggedinUser {
                    Section("계정 정보") {
                        NavigationLink {
                            SettingUserDetailView()
                        } label: {
                            SettingUserView()
                        }
                    }
                }
                Section("계정 로그인") {
                    if isLoggedinUser {
                        Button {
                            isLogoutAlert.toggle()
                        } label: {
                            Text("로그아웃")
                                .foregroundColor(.red)
                        }
                        .alert(isPresented: $isLogoutAlert) {
                            Alert(title: Text("로그아웃 "),
                                  message: Text("해당 계정이 로그아웃 됩니다."),
                                  primaryButton: .destructive(Text("확인"),action: {
                                // 로그아웃 시켜야함
                                isLoggedinUser.toggle()
                            }), secondaryButton: .cancel(Text("취소")))
                        }
                    } else {
                        NavigationLink {
                            SettingLoginView()
                        } label: {
                            Text("로그인")
                        }
                        
                        HStack {
                            Text("자동 로그인")
                            Toggle(isOn: $isToggleAutomaticLogin) {
                                //
                            }
                        }
                    }
                }
                Section("알림") {
                    NavigationLink {
                        // 푸시 알림 설정
                        NotificationSettingsView()
                    } label: {
                        Text("푸시 알림 설정")
                    }
                }
                Section("정보") {
                    Button {
                        isShowingTermsView.toggle()
                    } label: {
                        HStack {
                            Text("약관 및 정책")
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color(uiColor: .systemGray3))
                                .font(.footnote)
                                .bold()
                        }
                    }
                    .foregroundColor(.black)
                    .sheet(isPresented: $isShowingTermsView) {
                        SettingTermsView()
                    }
                    NavigationLink {
                        SettingDevInfoView()
                    } label: {
                        Text("개발자 소개")
                    }
                    HStack {
                        Text("버전 정보")
                        Spacer()
                        Text("ver 1.00.0")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
