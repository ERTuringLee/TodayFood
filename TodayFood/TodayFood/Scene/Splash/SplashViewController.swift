//
//  ViewController.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/25.
//

import UIKit

class SplashViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let vc = ViewControllerManager.shared.homeViewController()
            self.navigationController?.viewControllers = [vc]
        })
    }


}

