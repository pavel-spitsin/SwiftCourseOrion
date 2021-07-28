//
//  Restaurant.swift
//  MVVMRxSwiftTest
//
//  Created by Pavel Spitcyn on 26.07.2021.
//

import Foundation

struct Restaurant: Decodable {
    let name: String
    let cuisine: Cuisine
}

enum Cuisine: String, Decodable {
    case european
    case indian
    case mexican
    case french
    case english
}
