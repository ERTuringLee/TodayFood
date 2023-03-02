//
//  SideMenuViewController.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/26.
//

import UIKit

class SideMenuViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTouchedRecommendListButton(_ sender: Any) {
        let vc = ViewControllerManager.shared.recommendListViewController()
        dismiss(animated: false)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onTouchedSettingButton(_ sender: Any) {
        let vc = ViewControllerManager.shared.settingViewController()
        dismiss(animated: false)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
