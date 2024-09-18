//
//  ViewController.swift
//  WhereWeatherApp
//
//  Created by Tony Lieu on 9/17/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    public var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    public var displayView: UIHostingController<DetailsView>?
    private var viewModel: WeatherViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.VMSetup()
        self.UISetup()
    }

    func VMSetup() {
        viewModel = WeatherViewModel(networkManager: NetworkManager(),
                              locationManager: LocationManager())
        if let viewModel = viewModel {
            displayView = UIHostingController(rootView: DetailsView(viewModel: viewModel))
        }
    }
    
    func UISetup() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15)
        ])
        
        guard let displayView = displayView else { return }
        view.addSubview(displayView.view)
        self.addChild(displayView)
        displayView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            displayView.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            displayView.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            displayView.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25),
            displayView.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -40)
        ])
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        Task {
            await viewModel?.weatherCity(city: searchText)
        }
        searchBar.resignFirstResponder()
    }
}

