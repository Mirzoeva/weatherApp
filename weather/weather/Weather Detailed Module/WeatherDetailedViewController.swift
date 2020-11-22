//
//  WeatherDetailedViewController.swift
//  weather
//
//  Created by Ума Мирзоева on 22.11.2020.
//

import UIKit

class WeatherDetailedViewController: UIViewController {
    
    private let viewModel: WeatherDetailedViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(WeatherCityTableViewCell.self, forCellReuseIdentifier: "CustomCellId")
        tableView.rowHeight = 92
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    init(viewModel: WeatherDetailedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.cityName
        setupLayout()
        viewModel.loadCityForecast { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension WeatherDetailedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellId", for: indexPath) as? WeatherCityTableViewCell {
            cell.dataSource = viewModel.dataSource[indexPath.row]
            viewModel.loadImage(
                imageName: viewModel.dataSource[indexPath.row].weather?.first?.icon ?? "") { data in
                cell.imageData = data
            }
            return cell
        }
        return UITableViewCell()
    }
    
}
