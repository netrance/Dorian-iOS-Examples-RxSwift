//
//  ViewController.swift
//  RxAlamofireEx
//
//  Created by Dohyoung Lee on 2020/06/14.
//  Copyright © 2020 Dorian Lee. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewController: UIViewController {

    let vm = ViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet var lblHardforkVersion: UILabel!
    @IBOutlet var lblFollowCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }

    func setupRx() {
        vm.requestHardforkVersion().subscribe(
            onNext: { [weak self] hardforkVersion in
                self?.lblHardforkVersion.text = "Hardfork Version: \(hardforkVersion)"
            },
            onError: { [weak self] error in
                // 오류 팝업 띄우는 코드는 생략
            },
            onCompleted: {
                print("completed")
            }
        ).disposed(by: disposeBag)

        vm.requestFollowCount(account: "dorian-lee").subscribe(
            onNext: { [weak self] followCount in
                self?.lblFollowCount.text =
                    "Account: \(followCount.account)\n"
                    + "Following: \(followCount.followingCount)\n"
                    + "Follower: \(followCount.followerCount)"
            },
            onError: { [weak self] error in
                // 오류 팝업 띄우는 코드는 생략
            },
            onCompleted: {
                print("completed")
            }
        ).disposed(by: disposeBag)
    }

}

