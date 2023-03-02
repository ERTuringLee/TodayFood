//
//  SearchService.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/28.
//

import Foundation
import Moya
import RxSwift

final class SearchService: BaseService<SearchAPI> {
    static let shared = SearchService()
    private override init() {}
    
    func getLocalWithKeyword(x: Double, y: Double, page: Int) -> Single<Response> {
        return request(.getLocalWithKeyword(x: x, y: y, page: page))
    }
}
