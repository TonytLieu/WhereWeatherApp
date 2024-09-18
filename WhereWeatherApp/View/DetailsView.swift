//
//  InformationView.swift
//  WhereWeatherApp
//
//  Created by Tony Lieu on 9/17/24.
//


import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                imageDisplayView
                displayDetailsView
            }
        }
    }
    
    var imageDisplayView: some View {
        VStack {
            if let iconId = viewModel.weatherDisplay?.weather?.first?.icon {
                let urlString = "https://openweathermap.org/img/wn/\(iconId)@4x.png"
                if let url = URL(string: urlString) {
                    Spacer()
                    AsyncImage(url: url, content: { image in
                        image
                    }, placeholder: {
                        ProgressView()
                    })
                }
            }
        }
    }
    
    var displayDetailsView: some View {
        VStack(spacing: 20) {
            if let name = viewModel.weatherDisplay?.name {
                Text(name)
                    .fontWeight(.bold)
                Spacer()
            }
            if let feelsLike = viewModel.weatherDisplay?.main?.feels_like {
                infoView(param: "Feels Like:", value: (String(feelsLike)+" \u{00B0}C"))
            }
            if let temp = viewModel.weatherDisplay?.main?.temp {
                infoView(param: "Temperature:", value: (String(temp)+" \u{00B0}C"))
            }
            if let humidity = viewModel.weatherDisplay?.main?.humidity {
                infoView(param: "Humidity:", value: (String(humidity)+" \u{0025}"))
            }
            if let windSpeed = viewModel.weatherDisplay?.wind?.speed {
                infoView(param: "Wind Speed:", value: (String(windSpeed)+" mph"))
            }
        }
    }
    
    func infoView(param: String, value: String) -> some View {
        HStack {
            Text(param)
            Spacer()
            Text(value)
        }
        .padding(.horizontal, 25)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: WeatherViewModel(networkManager: MockNetwork(),
                                                       locationManager: MockLocationMap()))
    }
}
