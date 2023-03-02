//
//  ViewControllerManager.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/25.
//

import UIKit

class ViewControllerManager {
    static let shared = ViewControllerManager()
    private init() {}
    
    func homeViewController() -> HomeViewController {
        let storyboard = UIStoryboard.main()
        return storyboard.instantiateViewController(identifier: "HomeViewController")
    }
    
    func sideMenuViewController() -> SideMenuViewController {
        let storyboard = UIStoryboard.main()
        return storyboard.instantiateViewController(identifier: "SideMenuViewController")
    }
    
    func recommendListViewController() -> RecommendListViewController {
        let storyboard = UIStoryboard.main()
        return storyboard.instantiateViewController(identifier: "RecommendListViewController")
    }
    
    func settingViewController() -> SettingViewController {
        let storyboard = UIStoryboard.main()
        return storyboard.instantiateViewController(identifier: "SettingViewController")
    }
}
