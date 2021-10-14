//
//  newShereCalenderApp.swift
//  newShereCalender
//
//  Created by 田野恭一 on 2021/10/05.
//

import SwiftUI
import Firebase

@main
struct newShereCalenderApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
