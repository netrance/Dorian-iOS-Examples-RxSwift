//
//  FollowCount.swift
//  RxAlamofireEx
//
//  Created by Dohyoung Lee on 2020/06/19.
//  Copyright © 2020 Dorian Lee. All rights reserved.
//

import Foundation
import ObjectMapper

final class FollowCount: Mappable {

    var account: String = ""
    var followingCount: Int = 0
    var followerCount: Int = 0

    init() {
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        account <- map["account"]
        followingCount <- map["following_count"]
        followerCount <- map["follower_count"]
    }

}
