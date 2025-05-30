//
//  ContentView.swift
//  SwiftyWeather
//
//  Created by Robert Beachill on 30/05/2025.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.cyan.opacity(0.75))
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Image(systemName: "cloud.sun.rain.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                        .symbolRenderingMode(.multicolor)
                        Text("Wild Weather")
                            .font(.largeTitle)
                        Text("42°F")
                            .font(.system(size: 150, weight: .thin))
                        Text("Wind 10mph - Feels like 36°F")
                            .font(.title2)
                            .padding(.bottom)
                }
                .foregroundStyle(.white)
            }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            //TODO: Add action code here
                        } label: {
                            Image(systemName: "gear")
                                .foregroundStyle(.white)
                        }

                    }
                }
            

        }
    }
}
#Preview {
    WeatherView()
}
