//
//  RegisterView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/07.
//

import SwiftUI
import Firebase

enum TorokuAlert{
    case alert1
    case alert2
    case alert3
}

// MARK: 新規登録画面
struct RegisterView: View {
    
    //各入力項目を格納する変数
    @State var email = ""   //メールアドレス
    @State var pass = ""    //パスワード
    //アラートを表示するための変数
    @State var erroralert = false
    @State var erroralerttype:TorokuAlert = .alert1
    
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
                verify()
                //Sheetを閉じる処理
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("アカウントを作成する")
                    .frame(width:300, height: 30)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            })
                .fullScreenCover(isPresented: $profilesettingsheet) {
                    ProfileSetting()    //fullsheetでプロフィール設定画面へ
                }
            //各エラーに対応したアラートを表示する
                .alert(isPresented: $erroralert){
                    switch erroralerttype{
                    case .alert1:
                        //どちらかが空白の時に表示されるエラー
                        return Alert(
                            title: Text("登録エラー"),
                            message: Text("メールアドレスかパスワードが空白です。")
                        )
                    case .alert2:
                        //正規表現が正しくない場合に表示されるエラー
                        return Alert(
                            title: Text("登録エラー"),
                            message: Text("正しいメールアドレスを入力してください")
                        )
                    case .alert3:
                        //新規登録が失敗した場合に表示されるエラー
                        return Alert(
                            title: Text("登録エラー"),
                            message: Text("パスワードは6文字以上です。")
                        )
                    }
                    
                }
            Spacer()
        }
    }
    
    //新規登録を行う処理
    func verify(){
        //文字がきちんと入力されているかの判定
        if self.email != "" && self.pass != "" && validateEmail(candidate: email) == true{
            Auth.auth().createUser(withEmail: email, password: pass) { user, error in
                if (user != nil && error == nil) {
                    //新規登録成功
                    print("登録完了")
                    self.profilesettingsheet = true //フラグ変更
                }else{
                    //新規登録失敗
                    print("新規登録失敗")
                    erroralerttype = .alert3
                    self.erroralert.toggle()
                }
            }
        }else if self.email == "" || self.pass == ""{
            //パスワードかメールアドレスが空白の場合の処理
            erroralerttype = .alert1
            self.erroralert.toggle()
            print("空白エラー")
        }else{
            //正規表現が間違っていた場合
            erroralerttype = .alert2
            self.erroralert.toggle()
            print("正規表現エラー")
        }
    }
    
    // メールアドレスの確認するための正規表現
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
