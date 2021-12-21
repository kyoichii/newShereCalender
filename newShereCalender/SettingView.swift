//
//  SettingView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/26.
//

import SwiftUI
import Firebase

struct SettingView: View {
    //Sheetを閉じるために必要な変数
    @Environment(\.presentationMode) var presentationMode
    @State var profileeditflag: Bool = false    //プロフィール編集画面表示フラグ
    @State var logoutalert: Bool = false        //ログアウトアラート表示フラグ
    @State var accountdeletealert: Bool = false //アカウント削除アラート表示フラグ
    @State var changeprofile: Bool = false      //プロフィール変更表示アラート
    @Binding var username:String                //ユーザ名が格納
    @Binding var birthday:String                //誕生日が格納
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
                Button("編集"){
                    changeprofile.toggle()
                }
                .padding()
                .font(.system(size: 23))
                .foregroundColor(.black)
                .sheet(isPresented: $changeprofile){
                    ChangeProfileVuew()
                }
            }
            Spacer()
            //現在ログインしているユーザー名と誕生日を表示する
            ZStack {
                Circle().stroke(Color(red: 66/255, green: 237/255, blue: 51/255, opacity: 0.7), lineWidth: 6)
                VStack {
                    Text("\(username)")
                        .font(.system(size: 50))
                        .lineLimit(1)
                        .padding()
                    Text("\(birthday)")
                        .font(.system(size: 30))
                }
            }.frame(width:300, height: 300)
            Spacer()
            //アカウント情報変更関連
            VStack{
                Text("アカウント")
                    .bold()
                    .font(.system(size: 30))
                    .frame(maxWidth:.infinity, alignment: .leading)
                Spacer().frame(height:20)
                HStack {
                    Spacer().frame(width:20)
                    //メールアドレス変更
                    Button("メールアドレスを変更"){
                        //メールアドレス変更画面へ
                    }.frame(maxWidth:.infinity, alignment: .leading)
                }
                Spacer().frame(height:15)
                HStack {
                    Spacer().frame(width:20)
                    Button("パスワードを変更"){
                        //パスワード変更画面へ
                    }.frame(maxWidth:.infinity, alignment: .leading)
                }
                
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame(height:40)
            //ログアウト関連処理
            VStack{
                Text("ログアウト")
                    .bold()
                    .font(.system(size: 30))
                    .frame(maxWidth:.infinity, alignment: .leading)
                Spacer().frame(height:20)
                HStack {
                    Spacer().frame(width:20)
                    //ログアウトボタン
                    Button("ログアウト"){
                        self.logoutalert.toggle()
                    }
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .alert("ログアウト", isPresented: $logoutalert){
                        Button("いいえ"){}
                        Button("はい"){
                            //ログアウト処理
                            try! Auth.auth().signOut()
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name:NSNotification.Name("status"), object: nil)
                        }
                    }message: {
                        Text("ログアウトしますか？")
                    }
                }
                Spacer().frame(height:15)
                HStack {
                    Spacer().frame(width:20)
                    //アカウント削除ボタン
                    Button("退会してアカウントを削除"){
                        self.accountdeletealert.toggle()
                    }
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .alert("アカウント削除", isPresented: $accountdeletealert){
                        Button("いいえ"){}
                        Button("はい"){
                            //アカウント削除処理
                        }
                    }message: {
                        Text("全てのデータが消去され、アカウントも削除されますがよろしいでしょうか？")
                    }
                }
                
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(username: .constant("ECC太郎"), birthday: .constant("11月21日"))
    }
}
