//
//  CalenderList.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/11/04.
//

import SwiftUI

struct CalendarList: View {
    @Binding var year : Int
    @Binding var month : Int
    var startdaynumber : Int
    var weeknumber : Int
    var days : Int
    var middleweek : Int
    var lastweeknumber : Int
    let column = 7
    let int = 1
    
    
    
    init(year:Binding<Int>,month:Binding<Int>,week:Int,start:Int,days:Int){
        self._year = year
        self._month = month
        self.weeknumber = week
        self.startdaynumber = start
        self.days = days
        self.middleweek = (days - (7 - start)) / 7
        self.lastweeknumber = (days - (7 - start)) % 7  //各月の最終週が格納されている変数
    }
    
    var body: some View {
        //MARK: 月が4週の場合
        VStack{
            if self.weeknumber == 4{
                // 1週
                HStack {
                    if self.startdaynumber != 0{
                        ForEach(0..<self.startdaynumber,id:\.self){ index in
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:112.5)
                                    .foregroundColor(Color.clear)
                                Text("")
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                                
                            }
                        }
                    }
                    
                    ForEach(0..<(self.column-self.startdaynumber),id:\.self){ index in
                        ZStack(alignment: .top){
                            RoundedRectangle(cornerRadius: 5).frame(width:50,height:90)
                                .foregroundColor(Color.clear)
                            Button("\(index+1)"){
                                print("\(month)月\(index + 1)日")
                            }
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            
                        }
                    }
                }
                Divider()       // 仕切り線の挿入
                // 2週
                HStack{
                    ForEach(0..<self.column,id:\.self){ index in
                        ZStack(alignment: .top){
                            RoundedRectangle(cornerRadius: 5).frame(width:50,height:112.5)
                                .foregroundColor(Color.clear)
                            Button("\((self.column-self.startdaynumber)+1+index)"){
                                print("\(month)月\((self.column-self.startdaynumber)+1+index)日")
                            }
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        }
                    }
                }
                Divider()       // 仕切り線の挿入
                // 3週
                HStack{
                    ForEach(0..<self.column,id:\.self){ index in
                        ZStack(alignment: .top){
                            RoundedRectangle(cornerRadius: 5).frame(width:50,height:112.5)
                                .foregroundColor(Color.clear)
                            Button("\(((7-self.startdaynumber)+1+index)+7)"){
                                print("\(month)月\(((7-self.startdaynumber)+1+index)+7)日")
                            }
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        }
                    }
                }
                Divider()       // 仕切り線の挿入
                // 4週
                HStack{
                    if self.lastweeknumber != 0{
                        ForEach(0..<self.lastweeknumber,id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:112.5)
                                    .foregroundColor(Color.clear)
                                Button("\(((7-self.startdaynumber)+1+index)+14)"){
                                    print("\(month)月\(((7-self.startdaynumber)+1+index)+14)日")
                                }
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            }
                            Divider()       // 仕切り線の挿入
                        }
                        
                    }else{
                        ForEach(0..<7,id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:112.5)
                                    .foregroundColor(Color.clear)
                                Button("\(((7-self.startdaynumber)+1+index)+14)"){
                                    print("\(month)月\(((7-self.startdaynumber)+1+index)+14)日")
                                }
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            }
                        }
                        Divider()       // 仕切り線の挿入
                    }
                }
            }
        }
        //MARK: 月が5週の場合
        VStack{
           
            if self.weeknumber == 5{
                
                // 1週
                HStack {
                    if self.startdaynumber != 0{
                        ForEach(0..<self.startdaynumber,id:\.self){ index in
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:90)
                                    .foregroundColor(Color.clear)
                                Text("")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    
                    ForEach(0..<(self.column-self.startdaynumber),id:\.self){ index in
                        ZStack(alignment: .top){
                            RoundedRectangle(cornerRadius: 5).frame(width:50,height:90)
                                .foregroundColor(Color.clear)
                            
                            Button("\(index+1)"){
                                print("\(month)月\(index + 1)日")
                            }
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            
                        }
                    }
                }
                Divider()       // 仕切り線の挿入
                // 2週
                HStack{
                    ForEach(0..<self.column,id:\.self){ index in
                        ZStack(alignment: .top){
                            RoundedRectangle(cornerRadius: 5).frame(width:50,height:90)
                                .foregroundColor(Color.clear)
                            Button("\((self.column-self.startdaynumber)+1+index)"){
                                print("\(month)月\((self.column-self.startdaynumber)+1+index)日")
                            }
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        }
                    }
                }
                Divider()       // 仕切り線の挿入
                // 3週
                HStack{
                    ForEach(0..<self.column,id:\.self){ index in
                        ZStack(alignment: .top){
                            RoundedRectangle(cornerRadius: 5).frame(width:50,height:90)
                                .foregroundColor(Color.clear)
                            Button("\(((7-self.startdaynumber)+1+index)+7)"){
                                print("\(month)月\(((7-self.startdaynumber)+1+index)+7)日")
                            }
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        }
                    }
                }
                Divider()       // 仕切り線の挿入
                // 4週
                HStack{
                    ForEach(0..<self.column,id:\.self){ index in
                        ZStack(alignment: .top){
                            RoundedRectangle(cornerRadius: 5).frame(width:50,height:90)
                                .foregroundColor(Color.clear)
                            Button("\(((7-self.startdaynumber)+1+index)+14)"){
                                print("\(month)月\(((7-self.startdaynumber)+1+index)+14)日")
                            }
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        }
                        
                    }
                }
                Divider()       // 仕切り線の挿入
                // 5週
                HStack{
                    if self.lastweeknumber != 0{
                        ForEach(0..<self.lastweeknumber,id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:90)
                                    .foregroundColor(Color.clear)
                                Text("\(((7-self.startdaynumber)+1+index)+21)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        ForEach(0..<(7-self.lastweeknumber),id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:90)
                                    .foregroundColor(Color.clear)
                                Text("")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                
                            }
                        }
                    }else{
                        ForEach(0..<7,id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:90)
                                    .foregroundColor(Color.clear)
                                Button("\(((7-self.startdaynumber)+1+index)+21)"){
                                    print("\(month)月\(((7-self.startdaynumber)+1+index)+21)日")
                                }
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            }
                            
                        }
                    }
                }
            }
        }
        //MARK: 月が6週の場合
        VStack{
            if self.weeknumber == 6{
                VStack{
                    // 1週
                    HStack {
                        if self.startdaynumber != 0{
                            ForEach(0..<self.startdaynumber,id:\.self){ index in
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5).frame(width:50,height:75)
                                        .foregroundColor(Color.clear)
                                    Text("")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                        ForEach(0..<(self.column-self.startdaynumber),id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:75)
                                    .foregroundColor(Color.clear)
                                Button("\(index+1)"){
                                    print("\(month)月\(index + 1)日")
                                }
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()       // 仕切り線の挿入
                    // 2週
                    HStack{
                        ForEach(0..<self.column,id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:75)
                                    .foregroundColor(Color.clear)
                                Button("\((self.column-self.startdaynumber)+1+index)"){
                                    print("\(month)月\((self.column-self.startdaynumber)+1+index)日")
                                }
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()
                    // 3週
                    HStack{
                        ForEach(0..<self.column,id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:75)
                                    .foregroundColor(Color.clear)
                                Button("\(((7-self.startdaynumber)+1+index)+7)"){
                                    print("\(month)月\(((7-self.startdaynumber)+1+index)+7)日")
                                }
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()
                }
                VStack{
                    // 4週
                    HStack{
                        ForEach(0..<self.column,id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:75)
                                    .foregroundColor(Color.clear)
                                Button("\(((7-self.startdaynumber)+1+index)+14)"){
                                    print("\(month)月\(((7-self.startdaynumber)+1+index)+14)日")
                                }
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()
                    // 5週
                    HStack{
                        ForEach(0..<self.column,id:\.self){ index in
                            ZStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 5).frame(width:50,height:75)
                                    .foregroundColor(Color.clear)
                                Button("\(((7-self.startdaynumber)+1+index)+21)"){
                                    print("\(month)月\(((7-self.startdaynumber)+1+index)+21)日")
                                }
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()
                    // 6週
                    HStack{
                        if self.lastweeknumber != 0{
                            ForEach(0..<self.lastweeknumber,id:\.self){ index in
                                ZStack(alignment: .top){
                                    RoundedRectangle(cornerRadius: 5).frame(width:50,height:75)
                                        .foregroundColor(Color.clear)
                                    Button("\(((7-self.startdaynumber)+1+index)+28)"){
                                        print("\(month)月\(((7-self.startdaynumber)+1+index)+28)日")
                                    }
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                }
                            }
                            if self.lastweeknumber != 0{
                                ForEach(0..<(7-self.lastweeknumber),id:\.self){ index in
                                    ZStack(alignment: .top){
                                        RoundedRectangle(cornerRadius: 5).frame(width:50,height:75)
                                            .foregroundColor(Color.clear)
                                        Text("")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }else{
                            ForEach(0..<self.lastweeknumber,id:\.self){ index in
                                ZStack(alignment: .top){
                                    RoundedRectangle(cornerRadius: 5).frame(width:50,height:75)
                                        .foregroundColor(Color.clear)
                                    Button("\(((7-self.startdaynumber)+1+index)+28)"){
                                        print("\(month)月\(((7-self.startdaynumber)+1+index)+28)日")
                                    }
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
