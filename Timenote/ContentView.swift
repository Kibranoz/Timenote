//
//  ContentView.swift
//  Timenote
//
//  Created by Louis Couture on 2020-11-13.
//

import SwiftUI


struct ContentView: View {
    @State var timenote:timeNote = timeNote();
    @State var text:String = "";
    @State var time:String = "";
    @State var displayItem = -1;
    @State var pauseOrPlayButton = "play.fill"
    @State var title = "";
    @State var hours:Int = 0;
    @State var minutes:Int = 0;
    @State var seconds:Int = 0;
    //@State inout var test:String = "a"
    var body: some View {
        
        VStack{
            Text(time).bold().font(.system(size: 50))
            if (displayItem == 1){
                timeAdjustView(displayItem: $displayItem, timenote: $timenote, hours: $hours, minutes: $minutes, seconds: $seconds, pauseOrPlayButton: $pauseOrPlayButton, time: $time)
            }
            HStack(spacing: 98.0){
                Button(action: {
                    displayItem = 1
                }, label: {
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 40))
                        
                }).buttonStyle(PlainButtonStyle())
                Button(action: {
                    timenote.receiveText(_text: text)
                    text = timenote.sendText()
                }, label: {
                    Image(systemName: "text.insert")
                        .font(.system(size: 40))
                }).buttonStyle(PlainButtonStyle())
                Button(action: {
                    if (timenote.getSiEnPause()){
                    pauseOrPlayButton = "pause.fill"
                    timenote.play()
                    }
                    else {
                        pauseOrPlayButton = "play.fill"
                        timenote.pause()
                    }
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
                        time = timenote.getStrTime()
                    }
                   
                    
                    
                }, label: {
                    Image(systemName: pauseOrPlayButton)
                        .font(.system(size: 40))
                })
                .buttonStyle(PlainButtonStyle())
                Button(action: {

                    timenote.receiveText(_text: text)
                    timenote.write(text: text)
                    
   
                }, label: {
                    Image(systemName: "archivebox")
                        .font(.system(size: 40))
                }).buttonStyle(PlainButtonStyle())
                
                }
            }
            TextEditor(text: $text)
                .font(.system(size: 14))
            
        }
    
    func pauseAdjust(){
        if (timenote.getSiEnPause()){
        pauseOrPlayButton = "pause.fill"
        timenote.play()
        }
        
    }
        
    }


struct timeAdjustView:View{
    @Binding var displayItem:Int;
    @Binding var timenote:timeNote;
    @Binding var hours:Int;
    @Binding var minutes:Int;
    @Binding var seconds:Int;
    @State var strHours = "0"
    @State var strMinutes = "0"
    @State var strSeconds = "0"
    @Binding var pauseOrPlayButton:String;
    @Binding var time:String
    var body: some View{
        VStack{
        HStack{
            TextField("HH", text : $strHours)
                
            Text(":")
            TextField("MM", text : $strMinutes)
            Text(":")
            TextField("SS", text:$strSeconds)
        }
        Button(action: {
            pauseOrPlayButton = "pause.fill"
            timenote.play()

            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
                time = timenote.getStrTime()
            }
            hours = Int (strHours) ?? 0
            minutes = Int (strMinutes) ?? 0
            seconds = Int (strSeconds) ?? 0
            timenote.adjustTime(_hours: hours, _minutes: minutes, _seconds: seconds)
            displayItem = -1;

        }, label: {
            Text(NSLocalizedString("save", comment: "Save"))
        }).buttonStyle(LinkButtonStyle())
        }.padding(.horizontal, 100)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

