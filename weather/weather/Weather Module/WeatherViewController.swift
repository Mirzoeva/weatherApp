//
//  WeatherViewController.swift
//  weather
//
//  Created by Ума Мирзоева on 17.11.2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private let viewModel: WeatherViewModelProtocol?
    private let searchBar: UISearchBar
    private let cityTextField: UITextField
    private let weatherImageView: UIImageView
    private let tempreatureTextField: UITextField
    
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        self.searchBar = UISearchBar()
        self.cityTextField = UITextField()
        self.tempreatureTextField = UITextField()
        self.weatherImageView = UIImageView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
    }
    
}
