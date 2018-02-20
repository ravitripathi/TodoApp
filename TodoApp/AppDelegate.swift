//
//  AppDelegate.swift
//  TodoApp
//
//  Created by Ravi Tripathi on 12/02/18.
//  Copyright © 2018 Ravi Tripathi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Types
    enum ShortcutIdentifier: String {
        case first
        // MARK: - Initializers
        init?(fullType: String) {
            guard let last = fullType.components(separatedBy: ".").last else { return nil }
            self.init(rawValue: last)
        }
        
        // MARK: - Properties
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    // MARK: - Static Properties
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"
    
    // MARK: - Properties
    /*
     The app delegate must implement the window from UIApplicationDelegate
     protocol to use a main storyboard file.
     */
    
    var window: UIWindow?
    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func handleShortCutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        // Verify that the provided `shortcutItem`'s `type` is one handled by the application.
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        switch shortCutType {
        case ShortcutIdentifier.first.type:
            // Handle shortcut 1 (static).
        
            if let rootViewController = window?.rootViewController as? UINavigationController {
                if let viewController = rootViewController.viewControllers.first as? ViewController {
                    viewController.addItem()
                }
            }
            
            handled = true
            break
        default:
            break
        }
        
        return handled
    }
    
    // MARK: - Application Life Cycle
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        guard let shortcut = launchedShortcutItem else { return }
        _ = handleShortCutItem(shortcut)
        // Reset which shortcut was chosen for next time.
        launchedShortcutItem = nil
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var shouldPerformAdditionalDelegateHandling = true
        // If a shortcut was launched, display its information and take the appropriate action.
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortcutItem
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
        }
        
        return shouldPerformAdditionalDelegateHandling
    }
    
    /*
     Called when the user activates your application by selecting a shortcut on the home screen, except when
     application(_:,willFinishLaunchingWithOptions:) or application(_:didFinishLaunchingWithOptions) returns `false`.
     You should handle the shortcut in those callbacks and return `false` if possible. In that case, this
     callback is used if your application is already launched in the background.
     */
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
}







//Original AppDelegate code

//var window: UIWindow?
//
//
//func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//    // Override point for customization after application launch.
//
//    print("didFinishLaunchingWithOptions")
//    //MARK: - Shows filepath of app storage
//    print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
//    //        return true
//
//    //Shortcut stuff
//    var shouldPerformAdditionalDelegateHandling = true
//    // If a shortcut was launched, display its information and take the appropriate action
//    if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
//        launchedShortcutItem = shortcutItem
//        // This will block "performActionForShortcutItem:completionHandler" from being called.
//        shouldPerformAdditionalDelegateHandling = false
//    }
//
//    return shouldPerformAdditionalDelegateHandling
//}
//
//func applicationWillResignActive(_ application: UIApplication) {
//    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    print("applicationWillResignActive")
//
//}
//
//func applicationDidEnterBackground(_ application: UIApplication) {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    print("applicationDidEnterBackground")
//}
//
//func applicationWillEnterForeground(_ application: UIApplication) {
//    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    print("applicationWillEnterForeground")
//}
//
//func applicationDidBecomeActive(_ application: UIApplication) {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    print("applicationDidBecomeActive")
//}
//
//func applicationWillTerminate(_ application: UIApplication) {
//    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    print("applicationWillTerminate")
//}



// MARK:  - Code for Dynamic Shortcuts
// To be called in func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey:
// Install initial versions of our two extra dynamic shortcuts.
//        if let shortcutItems = application.shortcutItems, shortcutItems.isEmpty {
//            // Construct dynamic short item #3
//            let shortcut3UserInfo = [AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.play.rawValue]
//            let shortcut3 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.third.type,
//                                                             localizedTitle: "Play",
//                                                             localizedSubtitle: "Will Play an item",
//                                                             icon: UIApplicationShortcutIcon(type: .play),
//                                                             userInfo: shortcut3UserInfo)
//            // Construct dynamic short #4
//            let shortcut4UserInfo = [AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.pause.rawValue]
//            let shortcut4 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.fourth.type,
//                                                             localizedTitle: "Pause",
//                                                             localizedSubtitle: "Will Pause an item",
//                                                             icon: UIApplicationShortcutIcon(type: .pause),
//                                                             userInfo: shortcut4UserInfo)
//
//            // Update the application providing the initial 'dynamic' shortcut items.
//            application.shortcutItems = [shortcut3, shortcut4]
//        }

