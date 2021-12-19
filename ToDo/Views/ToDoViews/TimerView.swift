//
//  TaskView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 24.11.2021.
//

import SwiftUI

struct TimerView: View {
    var item: ItemModel
    var body: some View {
        Home(item: item)
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(item: ItemModel(name: "Cisco", isCompleted: false, priority: .third, date: getFomatted(date: Date()), pomodoros: []))
            .preferredColorScheme(.light)
            
    }
}

struct Home : View {
    
    var item: ItemModel
    @EnvironmentObject var tasksVM: TasksVM
    @Environment(\.presentationMode) var presentationMode
    
    var maxTime : Int = 1
    @State var start = true
    @State var to : CGFloat = 0
    @State var count = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{
        
        ZStack{
            
            Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
            
            
            VStack{
                
                ZStack{
                    
                    Circle()
                    .trim(from: 0, to: 1)
                        .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                    .frame(width: 280, height: 280)
                    
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                    .frame(width: 280, height: 280)
                    .rotationEffect(.init(degrees: -90))
                    
                    
                    VStack{
                        
                        Text("\(self.count / 60) min")
                            .font(.system(size: 65))
                            .fontWeight(.bold)
                        
                        Text("Of \(maxTime)")
                            .font(.title)
                            .padding(.top)
                    }
                }
                
                HStack(spacing: 20){
                    
                    Button(action: {
                        // <-- add failed pomodoro
                        tasksVM.addPomodoro(item: item, pomodoro: Pomodoro(time: count/60, isCompleted: false))
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        
                        HStack(spacing: 15){
                            
                            Image(systemName: "pause.fill")
                                .foregroundColor(.white)
                            
                            Text("Pause")
                                .foregroundColor(.white)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                    }
                }
                .padding(.top, 55)
            }
            
        }
        .onAppear(perform: {
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (_, _) in
            }
        })
        .onReceive(self.time) { (_) in
            
            if self.start{
                
                if self.count != maxTime * 60{
                    
                    self.count += 1
                    
                    withAnimation(.default){
                        self.to = CGFloat(self.count) / CGFloat(maxTime * 60)
                    }
                }
                else{
                    presentationMode.wrappedValue.dismiss()
                    self.start.toggle()
                    tasksVM.addPomodoro(item: item, pomodoro: Pomodoro(time: count/60, isCompleted: true))
                    self.Notify()
                }

            }
            
        }
    }
    
    func Notify(){
        
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "Timer Is Completed Successfully In Background !!!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
}
