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
    private let containerView: UIView
    
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        self.searchBar = UISearchBar()
        self.cityTextField = UITextField()
        self.tempreatureTextField = UITextField()
        self.weatherImageView = UIImageView()
        self.containerView = UIView()
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
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(containerTapped))
        containerView.addGestureRecognizer(gestureRecognizer)
        containerView.backgroundColor = .white
        
        searchBar.delegate = self
        cityTextField.placeholder = "Город"
        cityTextField.isUserInteractionEnabled = false
        tempreatureTextField.placeholder = "Температура"
        tempreatureTextField.isUserInteractionEnabled = false
        weatherImageView.image = UIImage(systemName: "cloud")
        weatherImageView.contentMode = .scaleAspectFit
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            containerView.layer.cornerRadius = 25
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
            containerView.layer.shadowRadius = 5
            containerView.layer.shadowOffset = .zero
            containerView.layer.shadowOpacity = 0.3
    }
    
    private func setupLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        view.addSubview(searchBar)
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        tempreatureTextField.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(cityTextField)
        containerView.addSubview(tempreatureTextField)
        containerView.addSubview(weatherImageView)
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            containerView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 105),
            
            cityTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            cityTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            
            tempreatureTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20),
            tempreatureTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            
            weatherImageView.leadingAnchor.constraint(equalTo: cityTextField.trailingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 100),
            weatherImageView.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
    }
    
    @objc private func containerTapped() {
        let controller = ViewBuilder.singleton.createDetailedViewController(city: cityTextField.text ?? "")
        navigationController?.pushViewController(controller, animated: true)
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
