//
//  TimeCounter.swift
//  practiceSwift
//
//  Created by Siddharth sen on 11/26/19.
//  Copyright © 2019 Siddharth sen. All rights reserved.
//

import Foundation
import Combine


//Whenever counter changes, objectWillChange publishes itself to any subs.
class TimeCounter: ObservableObject{
    let objectWillChange = PassthroughSubject<TimeCounter, Never>()
    
    //PassthroughSubject is general-purpose Combine publisher that we use when there isn't a more specific Combine publisher
    
    var timer: Timer?
    var counter = 0
    
    @objc func updateCounter(){
        counter += 1
        objectWillChange.send(self)
    }
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    //get rid of timer
    func killTimer(){
        timer?.invalidate() //? for non nil base values
        timer = nil
    }
}
