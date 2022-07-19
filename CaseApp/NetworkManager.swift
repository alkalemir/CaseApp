//
//  NetworkManager.swift
//  CaseApp
//
//  Created by Emir Alkal on 17.07.2022.
//

import Foundation
import Alamofire

struct NetworkManager {
    let url = URL(string: "http://localhost:8000/todos")!
    
    func getTodos(completion: @escaping ([ToDoModel]) -> Void) {
        AF.request(url).response { response in
            if let _ = response.error {
                print("something went wrong")
                return
            }
            if let data = response.data {
                let serializedData = try! JSONDecoder().decode([ToDoModel].self, from: data)
                completion(serializedData)
            }
        }
    }
    
    func postTodo(todo: ToDoModel, completion: @escaping (ToDoModel) -> Void) {
        AF.request(url, method: .post, parameters: todo, encoder: JSONParameterEncoder.default).response { response in
            if let _ = response.error {
                print("something went wrong")
                return
            }
            completion(todo)
        }
    }
    
    func toggleTodo(item: ToDoModel, onSuccess: @escaping (ToDoModel) -> Void) {
        var newItem = item
        newItem.isCompleted.toggle()
        AF.request("http://localhost:8000/todos/\(newItem.id)", method: .put, parameters: newItem, encoder: JSONParameterEncoder.default).response { response in
            if let _ = response.error {
                print("something went wrong")
                return
            }
            onSuccess(newItem)
        }
    }
    
    func deleteTodo(id: Int) {
        AF.request("http://localhost:8000/todos" + "/\(id)", method: .delete).response { response in
            if let _ = response.error {
                print("something went wrong")
                return
            }
        }
    }
    
    func updateTodo(item: ToDoModel, content: String, onSuccess: @escaping (ToDoModel) -> Void) {
        var newItem = item
        newItem.content = content
        
        AF.request("http://localhost:8000/todos/\(newItem.id)", method: .put, parameters: newItem, encoder: JSONParameterEncoder.default).response { response in
            if let _ = response.error {
                print("something went wrong")
                return
            }
            onSuccess(newItem)
        }
    }
}
