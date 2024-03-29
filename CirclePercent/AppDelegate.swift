//
//  AppDelegate.swift
//  CirclePercent
//
//  Created by Takaki Otsu on 2019/06/22.
//  Copyright © 2019 Takaki Otsu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Realm設定
        RealmController.realmConfig()
        // UserDefaultsを使ってフラグを保持する
        let userDefault = UserDefaults.standard
        // "firstLaunch"をキーに、Bool型の値を保持する
        let dict = ["firstLaunch": true]
        // デフォルト値登録
        // ※すでに値が更新されていた場合は、更新後の値のままになる
        userDefault.register(defaults: dict)
        // "firstLaunch"に紐づく値がtrueなら(=初回起動)、値をfalseに更新して処理を行う
        if userDefault.bool(forKey: "firstLaunch") {
            userDefault.set(false, forKey: "firstLaunch")
            print("初回起動の時だけ呼ばれるよ")
            let iDAO = ItemDAO();
            let item1 = Item(name: "hogehoge", value: 30);
            iDAO.addItem(item: item1, isUpdated: .error);
            let item2 = Item(name: "fizzfizz", value: 30);
            iDAO.addItem(item: item2, isUpdated: .error);
            let item3 = Item(name: "buzzbuzz", value: 40);
            iDAO.addItem(item: item3, isUpdated: .error);
            
        }
        print("初回起動じゃなくても呼ばれるアプリ起動時の処理だよ")
        
        //スプラッシュ時間設定
        sleep(2);
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

