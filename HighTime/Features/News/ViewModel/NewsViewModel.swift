//
//  NewsViewModel.swift
//  HighTime
//
//  Created by Mairambek on 19/08/2019.
//  Copyright © 2019 Sunrise. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsViewModel: NSObject {
    
    var errorBehaviorRelay = BehaviorRelay<Error>(value: NSError.init(message: ""))
    let newsBehaviorRelay = BehaviorRelay<[NewsModel]>(value: [])
    var reachability:Reachability?

    private let disposeBag = DisposeBag()
    private let repository = NewsRepository()
    
    func getNews(completion: @escaping (Error?) -> ()) {
        if isConnnected() == true {
        self.repository.getNews().subscribe(onNext: { (allNews) in
            self.newsBehaviorRelay.accept(allNews)
        }, onError: { (error) in
            self.errorBehaviorRelay.accept(error)

        }).disposed(by: disposeBag)
            
        } else {
            completion(NSError.init(message: "Нет соединения"))
        }
    }
    
    func isConnnected() -> Bool{
        do {
            try reachability = Reachability.init()
            
            if (self.reachability?.connection) == .wifi || (self.reachability?.connection) == .cellular {
                return true
            } else if self.reachability?.connection == .unavailable {
                return false
            } else if self.reachability?.connection == .none {
                return false
            } else {
                return false
            }
        }catch{
            return false
        }
    }
    
}
