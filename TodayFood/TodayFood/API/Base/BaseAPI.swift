//
//  BaseAPI.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/28.
//

import Foundation
import Moya

protocol BaseAPI: TargetType {}

extension BaseAPI {
    var baseURL: URL { URL(string: "https://dapi.kakao.com/v2")! }
    var method: Moya.Method { .get }
    var task: Task { .requestPlain }
    var headers: [String: String]? { ["Authorization": "KakaoAK \(Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY")!)"] }
}
