//
//  PresetAccumulatorInput.swift
//  RunLogger
//
//  Created by Javad Mammadbayli on 1/3/25.
//
import SwiftUI

struct PresetAccumulatorInput<T: ValueDisplayable>: View {
    var label: String
    var values: [T]
    @Binding var accumulator: T

    var body: some View {
        VStack {
            Text("\(label): \(accumulator.toString)")
                .font(.system(size: 28))

            ScrollView(.horizontal) {
                HStack {
                    ForEach(values) { value in
                        Button {
                            accumulator.value += value.value
                        } label: {
                            Text("\(value.value) \(value.unit)")
                                .lineLimit(2)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    PresetAccumulatorInput(label: "Distance",
                           values: [0.1, 0.2, 0.5, 1.0, 2.0, 5.0, 10.0],
                           accumulator: .constant(PresetMilesValue(0.5)))
}
