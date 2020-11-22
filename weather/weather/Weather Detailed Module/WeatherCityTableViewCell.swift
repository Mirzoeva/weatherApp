//
//  WeatherCityTableViewCell.swift
//  weather
//
//  Created by Ума Мирзоева on 22.11.2020.
//

import UIKit

class WeatherCityTableViewCell: UITableViewCell {
    
    var dataSource: List? {
        didSet {
            timeLabel.text = dataSource?.dtTxt?.split(separator: " ").joined(separator: "\n")
            tempreature.text = String(format: "%.2f", dataSource?.main?.temp ?? 0.0) + "°C"
        }
    }
    
    var imageData: Data? {
        didSet {
            guard let data = imageData else { return }
            iconImageView.image = UIImage(data: data)
        }
    }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let tempreature: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [timeLabel,
         tempreature,
         iconImageView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            tempreature.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            tempreature.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tempreature.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            iconImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            iconImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}
