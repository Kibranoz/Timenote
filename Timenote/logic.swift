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
    var timeBeginning = 0
    var pauseBeginning = 0;
    var enPause:Bool = true;
    var begin = true;
    
    var pauseTime:Int = 0
    init(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            
                self.tick()
    
           
        }
    }
    func getStrTime() -> String{
        
        var hr = Int(floor(Double(self.time/3600)));
        var min = Int(floor(Double((self.time/60)%60)));
        var sec = Int((self.time%60))
        
        var strtime:String = String(hr) + ":" + String(min) + ":" + String(sec)
        return strtime
    }
    func play(){
        if (self.begin){
            self.timeBeginning = Int(NSDate().timeIntervalSince1970)
            print(self.timeBeginning)
            self.begin = false
        }
        if (pauseTime != 0){
            var delta = self.pauseTime - self.pauseBeginning 
            self.timeBeginning += delta
        }
        self.enPause = false;
    }
    
    func write(text: String) {
        /**guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        guard let writePath = NSURL(fileURLWithPath: path).appendingPathComponent(folder) else { return }
        try? FileManager.default.createDirectory(atPath: writePath.path, withIntermediateDirectories: true)
        let file = writePath.appendingPathComponent(fileNamed + ".txt")
        try? text.write(to: file, atomically: false, encoding: String.Encoding.utf8)
        
         */
        let panel = NSSavePanel()
              panel.nameFieldLabel = "Enregistrer la note sous:"
              //panel.nameFieldStringValue =
              panel.canCreateDirectories = true
              panel.isExtensionHidden = false
              panel.canSelectHiddenExtension = true 
              panel.allowedFileTypes = ["txt","doc","pages"]
              panel.begin { response in
                if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url{
                      print(fileUrl)
                    
                    try? text.write(to:fileUrl,atomically: false,encoding: String.Encoding.utf8)
                  }
              }
    }
    func pause(){
        self.pauseBeginning = Int(NSDate().timeIntervalSince1970)
        self.enPause = true;
    }
    func getSiEnPause() -> Bool {
        return self.enPause
    }
    func sendText() ->String{
        return self.text;
    }
    func receiveText(_text:String) -> Void {
        self.text = _text;
        self.text += "\n" + "-" + getStrTime() + " : "
    }
    func adjustTime(_hours:Int, _minutes:Int, _seconds:Int){
        self.timeBeginning = Int(NSDate().timeIntervalSince1970) - ((_hours * 3600) + (_minutes*60) + _seconds)
        print(_minutes*60);
    }
    func tick(){
        if !(self.enPause){
            self.time = Int(NSDate().timeIntervalSince1970) - self.timeBeginning
            //print(self.timeBeginning)
            
        }
        if (self.enPause && !self.begin){
            self.pauseTime = Int(NSDate().timeIntervalSince1970)
            
        }
    }
    
}


