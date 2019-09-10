//
//  LessonRepository.swift
//  HighTime
//
//  Created by Mairambek on 27/08/2019.
//  Copyright © 2019 Sunrise. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

class LessonRepository: NSObject {
    
    func getLessonTutorial(lessonId: Int) -> Observable<VideoTutorialByLessonIdModel> {
        return Observable.create({ (observer) -> Disposable in
            ServiceManager.sharedInstance.getTutorialByLessonId(lessonId: lessonId, completion: { (response, error) in
                if response != nil{
                guard let jsonArray = response as? [String:Any] else {
                    return }
                guard let lesson = Mapper<VideoTutorialByLessonIdModel>().map(JSON: jsonArray) else {
                    observer.onError(error ?? Constant.BACKEND_ERROR)
                    return
                }
                observer.onNext(lesson)
                observer.onCompleted()
                } else {
                }
            })
            return Disposables.create()
        })
    }
    
}

