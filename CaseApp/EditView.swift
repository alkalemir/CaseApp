//
//  EditView.swift
//  CaseApp
//
//  Created by Emir Alkal on 18.07.2022.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var items: GetTodos
    @Binding var isShow : Bool
    @State var content: String
    var currentTodo: ToDoModel
    
    var body: some View {
        VStack{
            VStack(alignment:.leading,spacing: 20) {
                Spacer()
                CustomDivider(color: Color.blue)
                TextEditor(text: self.$content)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                    .padding()
                    
                CustomDivider(color: Color.blue)
                Spacer()
            }
                .padding()
                .padding(.horizontal)
            Spacer()
            Button {
                isShow.toggle()
                NetworkManager().updateTodo(item: currentTodo, content: content) { todo in
                    for idx in 0..<items.data.count {
                        if items.data[idx] == currentTodo {
                            items.data[idx] = todo
                        }
                    }
                }
                
            } label: {
                Text("Save")
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
            }
                .background(Color.blue)
                .clipShape(Capsule())
            Spacer()
        }
    }
}

