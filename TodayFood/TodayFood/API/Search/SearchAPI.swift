//
//  SearchAPI.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/28.
//

import Foundation
import Moya

enum SearchAPI {
    case getLocalWithKeyword(x: Double, y: Double, page: Int)
}

extension SearchAPI: BaseAPI {
    var path: String {
        switch self {
        case .getLocalWithKeyword:
            return "/local/search/keyword.json"
        }
    }
    
    var task: Task {
        switch self {
        case .getLocalWithKeyword(let x, let y, let page):
            return .requestParameters(parameters: ["x" : x, "y": y, "radius": 500, "category_group_code": "FD6", "size": 5, "query": "제로페이", "page": page], encoding: URLEncoding.queryString)
        }
    }
    
    
}
