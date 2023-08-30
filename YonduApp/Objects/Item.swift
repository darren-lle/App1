//
//  Item.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import Foundation

class Item {
    let title: String
    let moreDetails: String
    let imageURL: String
    
    init(title: String, moreDetails: String, imageURL: String) {
        self.title = title
        self.moreDetails = moreDetails
        self.imageURL = imageURL
    }
}
