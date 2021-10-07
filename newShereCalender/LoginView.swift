//
//  LoginView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/05.
//

import SwiftUI

//ログインしているかどうかの判断
struct LoginView: View {
    @State private var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var body: some View {
        VStack{
            if self.status{
                //ログイン済みならホームメニューへ
                HomeMenu()
            }else{
                //ログインしてないならログイン画面へ
                Login()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

//ログイン画面
struct Login: View{
    //各入力項目を格納させるための変数
    @State var email = ""   //メールアドレス
    @State var pass = ""    //パスワード
    var body: some View{
        VStack(alignment: .center){
            Text("ログイン")
                .font(.largeTitle)
                .fontWeight(.bold)
            VStack{
                TextField("メールアドレス", text: $email)
                    .padding(10)
                Divider().padding()
                SecureField("パスワード", text: self.$pass)
                    .padding(10)
            }
            .frame(width: 350, height: 160)
            .border(Color.gray)
            
            Button(action:{
                
            }, label: {
                Text("ログイン")
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .padding()
            })
        }
    }
}
