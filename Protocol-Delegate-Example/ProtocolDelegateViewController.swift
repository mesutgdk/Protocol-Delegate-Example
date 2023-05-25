//
//  ViewController.swift
//  Protocol-Delegate-Example
//
//  Created by Mesut Gedik on 25.05.2023.
//

import UIKit


extension ProtocolDelegateViewController: WeatherServiceDelegate {
    func didFetchWeather(_ weather: Weather) { // 5
        cityLabel.text = weather.city
        temperatureLabel.text = weather.temperature

        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: weather.imageName, withConfiguration: configuration)
        imageView.image = image
    }
}

extension ProtocolDelegateViewController: WeatherServiceDataSource {
    var city: String? {
        let _city: String? = "San Francisco"
        return _city
    }
}

class ProtocolDelegateViewController: UIViewController {
    let weatherService = WeatherService() // 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        weatherService.delegate = self // 2
        weatherService.dataSource = self
    }

    @objc func weatherPressed() {
        weatherService.fetchWeather() // 3
    }
    
    // MARK: - Controls
    let weatherButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fetch Weather", for: [])
        button.addTarget(ProtocolDelegateViewController.self, action: #selector(weatherPressed), for: .touchDown)
        return button
        }()

    var imageView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "zzz", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 999), for: .horizontal)

        return imageView
    }()


    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        return label
    }()

    func setupViews() {
        navigationItem.title = "Protocol Delegate"

        view.addSubview(weatherButton)

        weatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true

        let stackView = UIStackView()

        view.addSubview(stackView)

        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(temperatureLabel)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: weatherButton.bottomAnchor, multiplier: 3).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3).isActive = true

        cityLabel.widthAnchor.constraint(equalTo: temperatureLabel.widthAnchor).isActive = true
    }
}
