//
//  PriorityType.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 19.11.2021.
//

import Foundation

enum PriorityType: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    case first, second, third
}
