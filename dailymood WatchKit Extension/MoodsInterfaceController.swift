//
//  MoodsInterfaceController.swift
//  dailymood
//
//  Created by Adriana Gonzalez on 1/19/17.
//  Copyright © 2017 AMGM. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class MoodsInterfaceController: WKInterfaceController {

    struct Mood{
        var title: String!
        var image: UIImage!
    }
    
    let moods = [Mood(title: "Happy", image: UIImage(named: "happy")),
                 Mood(title: "Nerdy", image: UIImage(named: "nerd")),
                 Mood(title: "Cool", image: UIImage(named: "cool")),
                 Mood(title: "Whatever", image: UIImage(named: "whatever")),
                 Mood(title: "Sad", image: UIImage(named: "sad")),
                 Mood(title: "Angry", image: UIImage(named: "angry"))]

    @IBOutlet var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        table.setNumberOfRows(moods.count, withRowType: "moodRow")
        
        for index in 0..<moods.count{
            
            if let row = table.rowController(at: index) as? MoodRowController{
                    row.label.setText(moods[index].title)
                    row.image.setImage(moods[index].image)
            }
        }
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
        let mood = moods[rowIndex]
        let date = Date()
        UserDefaults.standard.set(mood.title, forKey: "lastMood")
        UserDefaults.standard.synchronize()
        
        WCSession.default().transferUserInfo(["date":date,"name":mood.title])
        
        if CLKComplicationServer.sharedInstance().activeComplications != nil{
            for comp in CLKComplicationServer.sharedInstance().activeComplications!{
                CLKComplicationServer.sharedInstance().reloadTimeline(for: comp)
            }
        }
        
        
        pop()
    }
    
   
}
