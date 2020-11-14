//
//  ContentView.swift
//  Timenote
//
//  Created by Louis Couture on 2020-11-13.
//

import SwiftUI

struct ContentView: View {
    var timenote:timeNote = timeNote();
    @State var text:String = "";
    var body: some View {
        VStack{
        Text("Timenote")
            .padding()
            Text("1:00:00").bold().font(.system(size: 50))
            HStack(spacing: 98.0){
                Button(action: {}, label: {
                    Text("􀎀")
                        .font(.system(size: 40))
                        
                }).buttonStyle(PlainButtonStyle())
                Button(action: {}, label: {
                    Text("􀋵")
                        .font(.system(size: 40))
                }).buttonStyle(PlainButtonStyle())
                Button(action: {}, label: {
                    Text("􀊄")
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
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
