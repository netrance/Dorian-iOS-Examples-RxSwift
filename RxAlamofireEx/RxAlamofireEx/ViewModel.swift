//
//  ViewModel.swift
//  RxAlamofireEx
//
//  Created by Dohyoung Lee on 2020/06/14.
//  Copyright © 2020 Dorian Lee. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift
import SwiftyJSON
import Then

final class ViewModel {

    let apiURL = "https://api.steemit.com"
    let jsonRPC = "2.0"
    let jsonContentType = "application/json"

    func requestHardforkVersion() -> Observable<String> {
        return RxAlamofire.requestJSON(
            .post,
            apiURL,
            parameters: [
                "jsonrpc": jsonRPC,
                "method": "condenser_api.get_hardfork_version",
                "params": [],
                "id": 1
            ],
            encoding: JSONEncoding.default,
            headers: ["Content-Type": jsonContentType]
        )
        .map { (response, any) -> String in
            guard let dict = any as? [String: Any] else {
                return ""
            }
            return dict["result"] as! String
        }
    }

    func requestFollowCount(account: String) -> Observable<FollowCount> {
        return RxAlamofire.requestJSON(
            .post,
            apiURL,
            parameters: [
                "jsonrpc": jsonRPC,
                "method": "follow_api.get_follow_count",
                "params": [
                    "account": account
                ],
                "id": 1
            ],
            encoding: JSONEncoding.default,
            headers: ["Content-Type": jsonContentType]
        )
        .map { (response, any) -> FollowCount in
            guard let dict = any as? [String: Any],
                let result = dict["result"] as? [String: Any],
                let followCount = FollowCount(JSON: result) else {
                return FollowCount()
            }

            return followCount
        }
    }

}
