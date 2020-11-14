//
//  logic.swift
//  Timenote
//
//  Created by Louis Couture on 2020-11-13.
//

import Foundation
import SwiftUI

class timeNote{
    var text = "";
    var time:Int = 0;
    var enPause:Bool = true;
    init(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            self.tick()
        }
    }
    func getStrTime() -> String{
        
        var hr = floor(Double(self.time/3600));
        var min = floor(Double(self.time/60));
        var sec = (self.time%60)
        var strtime:String = String(hr) + ":" + String(min) + ":" + String(sec)
        return strtime
    }
    func play(){
        enPause = false;
    }
    func pause(){
        enPause = true;
    }
    func getSiEnPause() -> Bool {
        return enPause
    }
    func sendText() ->String{
        return self.text;
    }
    func receiveText(_text:String) -> Void {
        self.text = _text;
        self.text += "\n" + "-" + getStrTime() + " : "
    }
    func tick(){
        if !(self.enPause){
            self.time+=1;
        }
    }
    
}


