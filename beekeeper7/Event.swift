//
//  Event.swift
//  beekeeper7
//
//  Created by 梶原敬太 on 2019/06/20.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import Foundation
import RealmSwift


class Event: Object {
    
    @objc dynamic var date: String = ""
    @objc dynamic var event: String = ""
    
}

