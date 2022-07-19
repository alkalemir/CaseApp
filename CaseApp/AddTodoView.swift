//
//  AddTodoView.swift
//  CaseApp
//
//  Created by Emir Alkal on 17.07.2022.
//

import SwiftUI

struct AddTodoView: View {
    @ObservedObject var items: GetTodos
    @Binding var isShow : Bool
    @State var addDescription = "Enter Description Here..."
    
    
    var body: some View {
        VStack{
            VStack(alignment:.leading,spacing: 20){
                Spacer()
                CustomDivider(color: Color.orange)
                TextEditor(text: self.$addDescription)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                    .padding()
                    .onTapGesture {
                        if (self.addDescription == "Enter Description Here...") {
                            self.addDescription = ""
                        }
                    }
                CustomDivider(color: Color.orange)
                Spacer()
            }
                .padding()
                .padding(.horizontal)
            Spacer()
            Button {
                NetworkManager().postTodo(todo: ToDoModel(id: 99, content: self.addDescription, isCompleted: false)) { todo in
                    NetworkManager().getTodos { _ in
                        items.data.append(todo)
                    } 
                }
                
                isShow.toggle()
            } label: {
                Text("Save")
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
            }
                .background(Color.orange)
                .clipShape(Capsule())
            Spacer()
        }
    }
}
