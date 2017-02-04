//
//  ComplicationController.swift
//  dailymood WatchKit Extension
//
//  Created by Adriana Gonzalez on 1/11/17.
//  Copyright © 2017 AMGM. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        var moodImg: UIImage!
        let defaults = UserDefaults.standard
        if let lastMood = defaults.string(forKey: "lastMood") {
            switch lastMood {
            case "Happy":
                moodImg = UIImage(named: "happy_alpha")
            case "Nerdy":
                moodImg = UIImage(named: "nerdy_alpha")
            case "Cool":
                moodImg = UIImage(named: "cool_alpha")
            case "Whatever":
                moodImg = UIImage(named: "whatever_alpha")
            case "Sad":
                moodImg = UIImage(named: "sad_alpha")
            case "Angry":
                moodImg = UIImage(named: "angry_alpha")
            default:
                moodImg = UIImage(named: "nothing")

            }
        }else{
            moodImg = UIImage(named: "nothing")
        }
        
        if complication.family == .modularSmall{
            let template = CLKComplicationTemplateModularSmallSimpleImage()
            let imageProvider = CLKImageProvider(onePieceImage: moodImg!)
            template.imageProvider = imageProvider
            
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)

        }
        
        if complication.family == .modularLarge{
            
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "Current mood")
            if let lastMood = defaults.string(forKey: "lastMood") {
                template.body1TextProvider = CLKSimpleTextProvider(text: lastMood)
            }

            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)

        }
        
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        
        if complication.family == .modularSmall{
            let template = CLKComplicationTemplateModularSmallSimpleImage()
            let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "nothing")!)
            template.imageProvider = imageProvider
            handler(template)

        }
        
        if complication.family == .modularLarge{
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "Current mood")
            template.body1TextProvider = CLKSimpleTextProvider(text: "Unset")
            handler(template)
            
        }
        
    }
    
}
