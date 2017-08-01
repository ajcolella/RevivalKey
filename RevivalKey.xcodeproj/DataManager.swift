//
//  DataManager.swift
//  KeyboardOfMiddleEarth
//
//  Created by ooo on 6/4/15.
//  Copyright (c) 2015 Rohan Revival. All rights reserved.
//

import Foundation

class DataManager {
    class func loadQuotesFromFile(success: ((data: NSData) -> Void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let filePath = NSBundle.mainBundle().pathForResource("LOTRQuotes", ofType:"json")
            var readError:NSError?
            if let data = NSData(contentsOfFile:filePath!,
                options: NSDataReadingOptions.DataReadingUncached,
                error:&readError) {
                    success(data: data)
            }
        })
    }    
}