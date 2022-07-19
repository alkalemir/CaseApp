//
//  ToDoModel.swift
//  CaseApp
//
//  Created by Emir Alkal on 17.07.2022.
//

import Foundation

struct ToDoModel: Identifiable, Hashable, Codable {
    var id: Int
    var content: String
    var isCompleted: Bool
}
