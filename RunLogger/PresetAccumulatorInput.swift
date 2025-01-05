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
    @State private var offset = CGSize.zero

    private var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            }
            .onEnded { _ in
                offset = .zero
            }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(label): \(accumulator.toString)")
                    .font(.system(size: 28))

                Spacer()

                Button {
                    accumulator.value = .zero
                } label: {
                    Text("Reset")
                        .foregroundStyle(.red)
                }
                .buttonStyle(.bordered)
            }


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
