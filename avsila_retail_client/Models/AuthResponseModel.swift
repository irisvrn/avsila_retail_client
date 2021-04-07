//
//  AuthResponseModel.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 07.04.2021.
//  Copyright © 2021 Eugene Izotov. All rights reserved.
//

import Foundation

struct authResponse: Codable {
    var token: String?
    var error: Bool
    var message: String?
}
