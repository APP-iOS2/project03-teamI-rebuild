//
//  SettingTermsView.swift
//  TicketLion_Comsumer
//
//  Created by 이승준 on 2023/09/06.
//

import SwiftUI
import SafariServices

struct SettingTermsView: UIViewControllerRepresentable {
    
    //@Binding var url: URL
    var url: URL = URL(string: "https://appschool3-ios.github.io/project03-teamI-about/PresentTeamI.html")!
        
    func makeUIViewController(context: Context) -> some UIViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}

struct SettingTermsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingTermsView()
    }
}
