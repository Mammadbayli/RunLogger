//
//  Run.swift
//  RunLogger
//
//  Created by Javad Mammadbayli on 1/3/25.
//

import Foundation
import SwiftData

@Model
final class Run {
    var timestamp: Date
    var duration: PresetMinutesValue
    var distance: PresetMilesValue

    init(
        timestamp: Date,
         duration: PresetMinutesValue,
         distance: PresetMilesValue
    ) {
        self.timestamp = timestamp
        self.duration = duration
        self.distance = distance
    }

    convenience init() {
        self.init(timestamp: .now,
                  duration: 0,
                  distance: 0.0)
    }
}

extension Run {
    var dateString: String {
        timestamp.formatted(date: .abbreviated, time: .shortened)
    }

    var detailsString: String {
        "\(distance.toString) in \(duration.toString)"
    }

    var string: String {
        "\(dateString) \(distance.toString) \(duration.toString)"
    }
}

protocol ValueDisplayable: Identifiable {
    associatedtype T: AdditiveArithmetic

    var id: T { get }
    var value: T { get set }
    var unit: String { get }
    var toString: String { get }
    init(_ value: T)
}

extension ValueDisplayable {
    var id: T {
        value
    }

    var toString: String {
        "\(value) \(unit)"
    }
}

@Model
final class PresetMinutesValue: ValueDisplayable {
    required init(_ value: Int) {
        self.value = value
    }

    var value: Int
    var unit = "mins"
}

extension PresetMinutesValue: ExpressibleByIntegerLiteral {
    convenience init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension PresetMilesValue: ExpressibleByFloatLiteral {
    convenience init(floatLiteral value: Float) {
        self.init(Decimal.init(string: String(value)) ?? 0.0)
    }
}

@Model
final class PresetMilesValue: ValueDisplayable {
    required init(_ value: Decimal) {
        self.value = value
    }

    var value: Decimal
    var unit = "miles"
}
