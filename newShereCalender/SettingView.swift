//
//  SettingView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/26.
//

import SwiftUI
import Firebase

struct SettingView: View {
    var body: some View {
        VStack{
            Text("テスト").bold()
            Button(action: {
                
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                
            }) {
                
                Text("ログアウト")
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 25)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
