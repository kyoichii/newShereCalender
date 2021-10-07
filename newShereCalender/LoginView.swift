//
//  LoginView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/05.
//

import SwiftUI

// MARK: ログインしているかどうかの判断
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

// MARK: ログイン画面
struct Login: View{
    //各入力項目を格納させるための変数
    @State var email = ""   //メールアドレス
    @State var pass = ""    //パスワード
    var body: some View{
        VStack(alignment: .center){
            Spacer()
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
            //パスワードリセットボタン
            Button(action: {
                //クリックイベントを後に追加
            }, label: {
                Text("パスワードを忘れた場合はこちら")
                    .font(.system(size: 13))
                    .padding()
            })
            //ログインボタン
            Button(action:{
                //クリックイベントを後に追加
            }, label: {
                Text("ログイン")
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(
                        top: 10, leading: 125, bottom: 10, trailing: 125
                    ))
                    .background(Color.green)
                    .cornerRadius(10)
            })
            Spacer()
            //アカウント作成ボタン
            Button(action:{
                //クリックイベントを後に追加
            }, label: {
                Text("アカウントがない場合は")
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                 + Text("作成する")
                    .font(.system(size: 17).bold())
                    .foregroundColor(Color.black)
            })
        }
    }
}
