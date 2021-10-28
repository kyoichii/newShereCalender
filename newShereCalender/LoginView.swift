//
//  LoginView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/05.
//

import SwiftUI
import Firebase

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
                Login(show: self.$show)
            }
        }.onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                
                self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
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
    @State var showingregisterSheet = false //新規登録画面を表示させるためのフラグ
    @State var error = ""   //ログイン処理でエラーが出たときにエラー文を格納する変数
    @Binding var show: Bool
    //アラートを表示するための変数
    @State var mailandpasserror = false //エラー
    @State var seikimailerror = false   //正規表現エラー
    
    var body: some View{
        VStack(alignment: .center){
            Spacer()
            
            //タイトル
            Text("ログイン")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            //ログイン入力項目
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
            
            //パスワードリセットボタン
            Button(action: {
                //パスリセットボタンクリック処理
                //内容(設定したメールアドレスにメールを送り、パスワードを再設定)
            }, label: {
                Text("パスワードを忘れた場合はこちら")
                    .font(.system(size: 13))
                    .padding()
            })
            
            //ログインボタン
            Button(action:{
                //ログインボタンクリック処理
                self.verify()
            }, label: {
                Text("ログイン")
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(
                        top: 10, leading: 125, bottom: 10, trailing: 125
                    ))
                    .background(Color.green)
                    .cornerRadius(10)
            })
            //各エラーに対応したアラートを表示する
            .alert(isPresented: $mailandpasserror) {
                switch(seikimailerror) {
                case false:
                    //どちらかが空白の時に表示されるエラー
                    return Alert(
                        title: Text("ログインエラー"),
                        message: Text("メールアドレスかパスワードが空白です。")
                    )
                case true:
                    //正規表現が正しくない場合に表示されるエラー
                    return Alert(
                        title: Text("ログインエラー"),
                        message: Text("正しいメールアドレスを入力してください")
                    )
                }
            }
            Spacer()
            
            //アカウント作成ボタン
            Button(action:{
                self.showingregisterSheet.toggle()  //フラグの変更
            }, label: {
                Text("アカウントがない場合は")
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                + Text("作成する")
                    .font(.system(size: 17).bold())
                    .foregroundColor(Color.black)
            })
                .sheet(isPresented:$showingregisterSheet){
                    RegisterView()  //新規登録画面へ
                }
        }
    }
    
    //ログインボタンが押された時に呼び出される処理
    func verify(){
        //文字がきちんと入力されているかの判定
        if self.email != "" && self.pass != "" && validateEmail(candidate: email) == true{
            //Firebase Authに認証を投げる
            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
                if err != nil{
                    self.error = err!.localizedDescription
                    return
                }
                //成功したとき
                print("ログイン成功")
                UserDefaults.standard.set(true, forKey: "status")   //キーバリュー変更
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }else if self.email == "" || self.pass == ""{
            self.error = "Please fill all the contents properly"
            //パスワードかメールアドレスが空白の場合の処理
            self.mailandpasserror.toggle()
            print("空白エラー")
        }else{
            //正規表現が間違っていた場合
            self.mailandpasserror.toggle()
            self.seikimailerror.toggle()
            print("正規表現エラー")
        }
    }
    
    // メールアドレスの確認するための正規表現
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
}
