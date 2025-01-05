//
//  RunSessionView.swift
//  RunLogger
//
//  Created by Javad Mammadbayli on 1/3/25.
//

import SwiftUI
import SwiftData

struct RunSessionView: View {
    private enum Mode {
        case create
        case edit
    }

    private let mode: Mode
    @Environment(\.modelContext) private var modelContext

    private let presetMinutes: [PresetMinutesValue] = [1, 2, 5, 10, 20, 50]
    private let presetMiles: [PresetMilesValue] = [0.1, 0.2, 0.5, 1.0, 2.0, 5.0, 10.0]
    var run: Run

    init() {
        mode = .create
        run = Run()
    }

    init(run: Run) {
        mode = .edit
        self.run = run
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DatePicker(selection: Bindable(wrappedValue: run).timestamp) {
                Text("Date")
                    .font(.system(size: 28))
            }

            PresetAccumulatorInput(label: "Duration",
                                   values: presetMinutes,
                                   accumulator:  Bindable(wrappedValue: run).duration)

            PresetAccumulatorInput(label: "Distance",
                                   values: presetMiles,
                                   accumulator:  Bindable(wrappedValue: run).distance)

            Button {
                switch mode {
                case .create:
                    modelContext.insert(run)
                case .edit:
                    break
                }

            } label: {
                Text("Done")
            }
            .disabled(run.distance.value == 0.0 || run.duration.value == 0)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
        .navigationTitle(mode == .create ? "New Run" : run.dateString)
    }
}

#Preview {
    RunSessionView(run: Run(timestamp: .now,
                            duration: 55,
                            distance: 7.1))
        .modelContainer(for: Run.self, inMemory: true)
}

