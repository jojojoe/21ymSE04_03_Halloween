//
//  DataEncoding.swift
//  HWymHalloWeen
//
//  Created by soone on 2021/11/05.
//  Copyright © 2021 sinew. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import StoreKit

class ExchangeManage: NSObject {
    class func exchangeWithSSK(objcetID: String, completion: @escaping (PurchaseResult) -> Void) {        
        SwiftyStoreKit.purchaseProduct(objcetID) { a in
            completion(a)
        }
    }
}
