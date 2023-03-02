//
//  SettingViewController.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/27.
//

import UIKit

class SettingViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTouchedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
