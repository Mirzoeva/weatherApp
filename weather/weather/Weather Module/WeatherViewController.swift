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
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        title = "Погода"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        searchBar.delegate = self
        cityTextField.placeholder = "Город"
        tempreatureTextField.placeholder = "Температура"
        weatherImageView.image = UIImage(systemName: "cloud")
        weatherImageView.contentMode = .scaleAspectFit
    }
    
    private func setupLayout() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        tempreatureTextField.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchBar)
        view.addSubview(cityTextField)
        view.addSubview(tempreatureTextField)
        view.addSubview(weatherImageView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            cityTextField.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            cityTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            tempreatureTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20),
            tempreatureTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 200),
            weatherImageView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
        
    }
    
    private func loadImage(imageName: String) {
        viewModel?.loadImage(imageName: imageName) { result in
            switch result {
            case .success(let data):
                self.weatherImageView.image = UIImage(data: data)
            case .failure:
                break
            }
        }
    }

}

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.sendSearchBarData(searchQuery: searchText) { result in
            switch result {
            case .success(let response):
                self.cityTextField.text = searchText
                self.tempreatureTextField.text = "\(response.main.temp - 273.15) °C"
                self.loadImage(imageName: response.weather.first?.icon ?? "")
            case .failure:
                break
            }
        }
    }
    
}
