//
//  HomeView.swift
//  CaseApp
//
//  Created by Emir Alkal on 17.07.2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var items = GetTodos()
    @State var isPresenting = false
    @State var showingPopup = false
    @State var idx: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            NavigationView {
                Group {
                    if items.data.isEmpty {
                            Image("Image")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    } else {
                        List {
                            ForEach(Array(zip(items.data.indices, items.data)), id: \.0) { index, item in
                                HStack {
                                    Button {
                                        NetworkManager().toggleTodo(item: item) { newTodo in
                                            for i in 0..<items.data.count {
                                                if items.data[i] == item {
                                                    items.data[i] = newTodo
                                                }
                                            }
                                        }
                                    } label: {
                                        Image(systemName: item.isCompleted ? "checkmark.square" : "square")
                                            .foregroundColor(item.isCompleted ? Color.green: Color.red)
                                    }.buttonStyle(PlainButtonStyle())
                                    if item.isCompleted {
                                        Text(item.content)
                                            .strikethrough()
                                    } else {
                                        Text(item.content)
                                    }
                                }
                                .onTapGesture {
                                    idx = index
                                    showingPopup.toggle()
                                }
                            }
                            .onDelete { idx in
                                idx.forEach { i in
                                    NetworkManager().deleteTodo(id: items.data[i].id)
                                    items.data.remove(at: i)
                                }
                            }
                        }
                        .navigationTitle("To Do List App")
                        .sheet(isPresented: $showingPopup) {
                            EditView(items: items, isShow: self.$showingPopup, content: items.data[idx].content, currentTodo: items.data[idx])
                        }
                    }
                }
            }
            Button {
                self.isPresenting.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding(.all)
                    .padding(.trailing ,25)
            }.sheet(isPresented: self.$isPresenting) {
                AddTodoView(items: items, isShow: self.$isPresenting)
            }
        }
    }
}
