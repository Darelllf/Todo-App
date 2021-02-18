//
//  EmptyListView.swift
//  Todo App
//
//  Created by Darell Legoferdanu on 18/02/21.
//

import SwiftUI



struct EmptyListView: View {
  @State private var isAnimated: Bool = false
  
  let images: [String] = [
    "illustration-no1",
    "illustration-no2",
    "illustration-no3"
  
  ]
  
  let tips: [String] = [
    "Use your time wisely.",
    "Slow and steady wins the race.",
    "Keep it short and sweet.",
    "Put hard task first.",
    "Reward your self after work.",
    "Each night schedule for tomorrow.",
  ]
    var body: some View {
      ZStack{
        VStack(alignment: .center, spacing: 20){
          Image("\(images.randomElement() ?? self.images[0])")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .layoutPriority(1)
          
          Text("\(tips.randomElement() ?? self.tips[0])")
            .layoutPriority(0.5)
            .font(.system(.headline, design: .rounded))
            
        }
        .padding(.horizontal)
        .opacity(isAnimated ? 1 : 0) // 1 = iya, 0 = tidak.
        .offset(y: isAnimated ? 0 : -50) // jka true maka di 0 jika tidak di -50
        .animation(.easeOut(duration: 1.5))
        .onAppear(perform:{
          self.isAnimated.toggle()
        })
      }
      .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
      .background(Color("ColorBase"))
      .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
