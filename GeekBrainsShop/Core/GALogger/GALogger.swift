//
//  GALogger.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 11.06.2022.
//

import Foundation
import FirebaseAnalytics

class GALogger {
    class func logEvent(name: String, key: String, value: String) {
        Analytics.logEvent(name, parameters: [key: value])
    }
}
