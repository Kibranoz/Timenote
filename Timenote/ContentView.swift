//
//  ContentView.swift
//  Timenote
//
//  Created by Louis Couture on 2020-11-13.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert:Bool = false;
    @State var nomFichier:String = "";
    @State var timenote:timeNote = timeNote();
    @State var text:String = "";
    @State var time:String = "";
    @State var displayItem = -1;
    @State var pauseOrPlayButton = "􀊄"
    @State var title = "";
    //@State inout var test:String = "a"
    var body: some View {
        
        VStack{
            TextField("Titre", text: $title)
            Text(time).bold().font(.system(size: 50))
            if (displayItem == 1){
                timeAdjustView(displayItem: $displayItem, timenote: $timenote, hours: 0, minutes: 0, seconds: 0)
            }
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
                Button(action: {
                    self.showingAlert = true
                    self.nomFichier = title
                    timenote.receiveText(_text: text)
                    timenote.write(text: text, to: title)
   
                }, label: {
                    Text("􀈭")
                        .font(.system(size: 40))
                }).buttonStyle(PlainButtonStyle()).alert(isPresented: $showingAlert ) {
                    Alert(title: Text("Sauvegardé"), message: Text("Sauvegardé sous " + self.nomFichier + ".txt dans TimeNoteFiles"), dismissButton: .default(Text("Ok")))
                    
                }
            }
            TextEditor(text: $text)
                .font(.system(size: 14))
            
        
            
            
            
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
        }.padding(.horizontal, 100)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
