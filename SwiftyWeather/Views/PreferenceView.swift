//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by Robert Beachill on 02/06/2025.
//

import SwiftUI
import SwiftData

struct PreferenceView: View {
    
    @Query var preferences: [Preference]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var locationName: String = ""
    @State private var latString: String = ""
    @State private var longString: String = ""
    @State private var selectedUnit: UnitSystem = .imperial
    @State private var degreeUnitShowing: Bool = true
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                TextField("location", text: $locationName)
                    .font(.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                Text("Latitude")
                    .bold()
                TextField("Latitude:", text: $latString)
                    .textFieldStyle(.roundedBorder)
                Text("Longitude:")
                    .bold()
                TextField("Longitude:", text: $longString)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                HStack {
                    Text("Units")
                    Spacer()
                    Picker("", selection: $selectedUnit) {
                        ForEach(UnitSystem.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                }
                .font(.title2)
                .bold()
                Toggle("Show F/C after temp value:", isOn: $degreeUnitShowing)
                    .font(.title2)
                HStack {
                    Spacer()
                    Text("42°\(degreeUnitShowing ? (selectedUnit == .metric ? "C" :"F") : "")")
                        .font(.system(size: 150, weight: .thin))
                    Spacer()
                }
                    
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                       dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                     // we only want to save one element to the array, so delete all others before we save:
                        if !preferences.isEmpty {
                            for preference in preferences {
                                modelContext.delete(preference)
                            }
                        }
                        let preference = Preference(
                            locationName: locationName,
                            latString: latString,
                            longString: longString,
                            selectedUnit: selectedUnit,
                            degreeUnitShowing: degreeUnitShowing
                        )
                        modelContext.insert(preference)
                        guard let _ = try? modelContext.save() else {
                            print("😡 ERROR: Save in PreferenceView did not work")
                            return
                        }
                        dismiss()
                    }
                }
            }
        }
        .task {
            guard !preferences.isEmpty else { return }
            let preference = preferences.first!
            locationName = preference.locationName
            latString = preference.latString
            longString = preference.longString
            selectedUnit = preference.selectedUnit
            degreeUnitShowing = preference.degreeUnitShowing
        }
    }
    }

#Preview {
    PreferenceView()
        .modelContainer(Preference.preview)
}
