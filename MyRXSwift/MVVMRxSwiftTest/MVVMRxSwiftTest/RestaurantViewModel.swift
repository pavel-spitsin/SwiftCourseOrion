//
//  RestaurantViewModel.swift
//  MVVMRxSwiftTest
//
//  Created by Pavel Spitcyn on 28.07.2021.
//

import Foundation

struct RestaurantViewModel {
    private let restaurant: Restaurant
    
    var displayText: String {
        return restaurant.name + " - " + restaurant.cuisine.rawValue.capitalized
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
}
