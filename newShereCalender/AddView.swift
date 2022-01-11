//
//  AddView.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/26.
//

import SwiftUI

//予定追加ビュー
struct AddView: View {
    //Sheetを閉じるために必要な変数
    @Environment(\.presentationMode) var presentationMode
    @State var changemozi = 0
    @State var title = ""
    //予定登録の日付を決める変数
    @State var showDatePicker: Bool = false
    @State var savedDate: Date? = nil
    //Dateフォーマット
    var dateFormat: DateFormatter {
        let dformat = DateFormatter()
        dformat.dateFormat = "yyyy年MM月dd日"
        return dformat
    }
    var body: some View {
        VStack{
            //画面上部のデザイン
            HStack{
                //カレンダー画面へ
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
                Button(action: {
                    
                }, label: {
                    if changemozi == 0{
                        Image(systemName: "checkmark")
                            .font(.system(size:30))
                            .foregroundColor(Color.black)
                            .padding()
                    }else{
                        Image(systemName: "keyboard")
                            .font(.system(size:30))
                            .foregroundColor(Color.black)
                            .padding()
                    }
                })
                .padding()
                .font(.system(size: 23))
                .foregroundColor(.black)
                
                
            }
            Spacer().frame(height:20)
            TextField("タイトル", text: $title)
                .font(.system(size: 20))
                .frame(height:50)
                .padding()
            Divider()
            Spacer().frame(height:60)
            //予定を登録する日付
            VStack{
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
                Divider()
            }
            Spacer()
            
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
