//
//  RegisterView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/07.
//

import SwiftUI

// MARK: 新規登録画面
struct RegisterView: View {
    
    //各入力項目を格納する変数
    @State var email = ""   //メールアドレス
    @State var pass = ""    //パスワード
    @Environment(\.presentationMode) var presentationMode   //Sheetを閉じるために必要な変数
    @State var profilesettingsheet = false //プロフィール設定画面を表示するためのフラグ
    
    var body: some View {
        VStack{
            HStack{
                //ログイン画面へ
                Button(action: {
                    //Sheetを閉じる処理
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "multiply")
                        .font(.system(size:30))
                        .foregroundColor(Color.black)
                        .padding()
                })
                Spacer()
            }
         Spacer()
            //タイトル
            Text("アカウント登録")
                .fontWeight(.bold)
                .font(.system(size:25))
            
            //アカウント登録入力項目
            VStack{
                TextField("メールアドレス", text: $email)
                    .keyboardType(.emailAddress)
                    .padding(10)
                Divider().padding()
                SecureField("6文字以上のパスワード", text: self.$pass)
                    .padding(10)
            }
            .frame(width: 350, height: 160)
            .border(Color.gray)
            .padding()
            
            //アカウント作成ボタン
            Button(action:{
                //アカウント作成ボタンクリック処理
                self.profilesettingsheet = true //フラグ変更
            }, label: {
                Text("アカウントを作成する")
                    .frame(width:300, height: 30)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }).fullScreenCover(isPresented: $profilesettingsheet) {
                ProfileSetting()    //fullsheetでプロフィール設定画面へ
            }
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
