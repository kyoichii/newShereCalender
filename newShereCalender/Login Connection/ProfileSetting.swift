//
//  ProfileSetting.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/07.
//

import SwiftUI
import Firebase

// MARK: プロフィール設定画面
struct ProfileSetting: View {
    //各入力項目を格納させる変数
    @State var name = ""                        //名前
    @State private var selectionDate = Date()   //日付
    //誕生日を指定するために必要な変数
    @State var showDatePicker: Bool = false
    @State var savedDate: Date? = nil
    //Dateフォーマット
    var dateFormat: DateFormatter {
        let dformat = DateFormatter()
        dformat.dateFormat = "yyyy年MM月dd日"
        return dformat
    }
    //databeseに接続
    let db = Firestore.firestore()
    //Sheetを閉じるために必要な変数
    @Environment(\.presentationMode) var presentationMode
    //ホーム画面遷移イベント
    @State var home = false
    
    var body: some View {
        VStack {
            Text("プロフィール編集")
                .font(.system(size: 20))
                .padding()
            Spacer()
            VStack{
                //名前の入力
                HStack{
                    Text("名前")
                    Spacer()
                }
                TextField("必須", text: $name)
                    .padding()
                    .font(.system(size:20))
                //生年月日の選択
                HStack{
                    Text("生年月日")
                    Spacer()
                }
                Button(action: {
                    showDatePicker.toggle()
                }, label: {
                    HStack {
                        Text(dateFormat.string(from: savedDate ?? Date()))
                            .font(.system(size:20))
                            .padding()
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                })
                //生年月日を選択するDatePickerの表示
                if showDatePicker {
                    DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $savedDate, selectedDate: savedDate ?? Date())
                        .animation(.linear)
                        .transition(.opacity)
                }
            }
            .padding()
            Spacer()
            //保存ボタン
            Button(action:{
                //保存ボタンクリックイベント
                setbutton()
            }, label: {
                Text("保存")
                    .frame(width:400, height: 30)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            })
        }
    }
    // MARK: ユーザー名などの登録処理
    func setbutton(){
        // 新規登録したユーザーのUIDを取得
        let userID = Auth.auth().currentUser!.uid
        //データを登録(ドキュメントに各ユーザのUIDを使用している)
        db.collection("user").document("\(userID)").setData([
            "name": "\(name)",
            "birthday": "\(dateFormat.string(from: savedDate ?? Date()))"
        ]) { err in
            if let err = err {
                //データバース登録失敗
                print("Error writing document: \(err)") //エラー内容の表示
                print("失敗")
            } else {
                //データベース登録成功
                print("成功!")
                //Sheetを閉じる処理
                presentationMode.wrappedValue.dismiss()
                UserDefaults.standard.set(true, forKey: "status")   //キーバリュー変更
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
    }
}

// MARK: 誕生日を決めるDatePicker
struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            DatePicker("", selection: $selectedDate, displayedComponents: .date).datePickerStyle(WheelDatePickerStyle()).environment(\.locale, Locale(identifier: "ja_JP"))
            Divider()
            HStack {
                
                Button(action: {
                    showDatePicker = false
                }, label: {
                    Text("キャンセル")
                })
                
                Spacer()
                
                Button(action: {
                    savedDate = selectedDate
                    showDatePicker = false
                }, label: {
                    Text("保存".uppercased())
                        .bold()
                })
                
            }
            .padding(.horizontal)
            
        }
        .padding()
    }
}

struct ProfileSetting_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetting()
    }
}
