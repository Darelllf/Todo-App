//
//  ContentView.swift
//  Todo App
//
//   Created by Darell Legoferdanu on 15/02/21.
//

import SwiftUI

struct ContentView: View {
  
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
  
  @State private var showingAddTodoView: Bool = false
  @State private var showingSettingsView: Bool = false
  
  @EnvironmentObject var iconSettings: IconNames
  
  var body: some View {
    Text("Hello, world!")
    NavigationView{
      ZStack{
        List{
          ForEach(self.todos, id: \.self){ todo in
            HStack{
              Text(todo.name ?? "Unknown")
              
              Spacer()
              
              Text(todo.priority ?? "Unknown")
            }
          }
          .onDelete(perform: deleteTodo)
        }
        .navigationBarTitle("Todo", displayMode: .inline)
        .navigationBarItems(
          leading: EditButton(),
          trailing:
            //          di ganti showingSettingsView
            Button(action: {
              self.showingSettingsView.toggle()
            }){
              Image(systemName: "paintbrush")
                .imageScale(.large)
            }
            .sheet(isPresented: $showingSettingsView){
//              diganti jadi SettingsView
              SettingsView().environmentObject(self.iconSettings)
            }
        )
        
        
        if todos.count == 0{
          EmptyListView()
        }
      }
      .sheet(isPresented: $showingAddTodoView){
        AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
      }
      .overlay(
        ZStack{
          Button(action: {
            self.showingAddTodoView.toggle()
          }){
            Image(systemName: "plus.circle.fill")
              .resizable()
              .scaledToFit()
              .background(Circle().fill(Color("ColorBase")))
              .frame(width: 48, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          }
        }
        .padding(.bottom, 15)
        .padding(.trailing, 15)
        , alignment: .bottomTrailing
      )
    }
  }
  
  private func deleteTodo(at offsets: IndexSet){
    for index in offsets{
      let todo = todos[index]
      managedObjectContext.delete(todo)
      
      do{
        try managedObjectContext.save()
      } catch{
        print(error)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    return ContentView().environment(\.managedObjectContext, context)
  }
}
