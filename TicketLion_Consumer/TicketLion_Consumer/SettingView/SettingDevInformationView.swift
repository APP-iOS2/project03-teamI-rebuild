//
//  SettingDevInformationView.swift
//  TicketLion_Comsumer
//
//  Created by J on 2023/09/06.
//

import SwiftUI
import SafariServices

struct SettingDevInformationView: UIViewControllerRepresentable {

    @Binding var url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}

//struct SettingDevInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingDevInformationView()
//    }
//}
