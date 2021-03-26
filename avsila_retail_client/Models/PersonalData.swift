//
//  PersonalData.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 13.03.2021.
//  Copyright © 2021 Eugene Izotov. All rights reserved.
//

import Foundation

struct PersonalDatas: Codable {
    let auth: String
    let message: String
    //let other_device: Float
    let user_data: UserDatas?
}

struct UserDatas: Codable {
    let email: String
    let id: String
    let last_name: String
    let login: String
    let name: String
    let phone: String
}

