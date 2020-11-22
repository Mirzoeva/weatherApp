//
//  ViewBuilder.swift
//  weather
//
//  Created by Ума Мирзоева on 22.11.2020.
//

import UIKit

class ViewBuilder {
    
    private let networkService: NetworkService
    
    static let singleton = ViewBuilder(networkService: NetworkService())
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func createWeatherViewController() -> UIViewController {
        let model = WeatherViewModel(networkService: networkService)
        let controller = WeatherViewController(viewModel: model)
        return controller
    }
    
    func createDetailedViewController(city: String) -> UIViewController {
        let model = WeatherDetailedViewModel(networkService: networkService, cityName: city)
        let controller = WeatherDetailedViewController(viewModel: model)
        return controller
    }
    
}
