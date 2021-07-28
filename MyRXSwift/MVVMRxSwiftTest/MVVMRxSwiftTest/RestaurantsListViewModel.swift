//
//  RestaurantsListViewModel.swift
//  MVVMRxSwiftTest
//
//  Created by Pavel Spitcyn on 28.07.2021.
//

import Foundation
import RxSwift

final class RestaurantsListViewModel {
    let title = "Restaurants"
    
    private let restaurantServise: RestaurantServiceProtocol
    
    init(restaurantService: RestaurantServiceProtocol = RestaurantService()) {
        self.restaurantServise = restaurantService
    }
    
    func fetchRestaurantViewModels() -> Observable<[RestaurantViewModel]> {
        restaurantServise.fetchRestaurants().map { $0.map { RestaurantViewModel(restaurant: $0) } }
    }
}
