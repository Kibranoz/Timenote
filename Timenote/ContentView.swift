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
    @State var pauseOrPlayButton = "􀊄"
    //@State inout var test:String = "a"
    var body: some View {
        ZStack {
        VStack{
        Text("Timenote")
            .padding()
            Text(time).bold().font(.system(size: 50))
            HStack(spacing: 98.0){
                Button(action: {
                    displayItem = 1
                }, label: {
                    Text("􀎀")
                        .font(.system(size: 40))
                        
                }).buttonStyle(PlainButtonStyle())
                Button(action: {
                    timenote.receiveText(_text: text)
                    text = timenote.sendText()
                }, label: {
                    Text("􀋵")
                        .font(.system(size: 40))
                }).buttonStyle(PlainButtonStyle())
                Button(action: {
                    if (timenote.getSiEnPause()){
                    pauseOrPlayButton = "􀊆"
                    timenote.play()
                    }
                    else {
                        pauseOrPlayButton = "􀊄"
                        timenote.pause()
                    }
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
                        time = timenote.getStrTime()
                    }
                   
                    
                    
                }, label: {
                    Text(pauseOrPlayButton)
                        .font(.system(size: 40))
                })
                .buttonStyle(PlainButtonStyle())
                Button(action: {}, label: {
                    Text("􀈭")
                        .font(.system(size: 40))
                }).buttonStyle(PlainButtonStyle())
            }
            TextEditor(text: $text)
        }
            
            if (displayItem == 1){
                timeAdjustView(displayItem: $displayItem, timenote: $timenote, hours: 0, minutes: 0, seconds: 0)
            }
            
        }
        
    }
}

struct timeAdjustView:View{
    @Binding var displayItem:Int;
    @Binding var timenote:timeNote;
    @State var hours:Int;
    @State var minutes:Int;
    @State var seconds:Int;
    
    var body: some View{
        VStack{
        HStack{
            TextField("HH", value: $hours, formatter: NumberFormatter())
            Text(":")
            TextField("MM", value: $minutes, formatter: NumberFormatter())
            Text(":")
            TextField("SS", value: $seconds, formatter: NumberFormatter())
        }
        Button(action: {
            timenote.adjustTime(_hours: hours, _minutes: minutes, _seconds: seconds)
            displayItem = -1;
        }, label: {
            Text("Enregistrer")
        }).buttonStyle(LinkButtonStyle())
        }.padding(.horizontal, 25.0).frame(minWidth: 300, idealWidth: 300, maxWidth: 300, minHeight: 100, idealHeight: 100, maxHeight: 250, alignment: .center).fixedSize(horizontal: true, vertical: true)
        
            .background(RoundedRectangle(cornerRadius: 2).fill(Color.white.opacity(1)))
        
        
            .overlay(RoundedRectangle(cornerRadius: 27).stroke(Color.black, lineWidth: 2))
        
            Spacer()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
