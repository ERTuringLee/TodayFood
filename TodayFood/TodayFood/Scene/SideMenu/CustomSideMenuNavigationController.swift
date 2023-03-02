//
//  SideMenuNavigation.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/26.
//

import UIKit
import SideMenu

class CustomSideMenuNavigationContoller: SideMenuNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentationStyle = .menuSlideIn
        self.presentationStyle.backgroundColor = .black
        self.presentationStyle.presentingEndAlpha = 0.8
        self.menuWidth = self.view.frame.width * 0.5
        self.leftSide = true
        self.statusBarEndAlpha = 0.0
        self.presentDuration = 0.5
        self.dismissDuration = 0.5
    }
}
