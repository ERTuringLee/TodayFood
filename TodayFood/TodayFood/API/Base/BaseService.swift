//
//  BaseService.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/28.
//

import Moya
import RxSwift


class BaseService<API: TargetType> {
    private let provider = MoyaProvider<API>()
    
    func request(_ api: API) -> Single<Response> {
        return provider.rx.request(api)
          .filterSuccessfulStatusCodes()
    }
}

