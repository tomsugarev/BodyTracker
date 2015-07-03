//
//  ProgressPointHelper.swift
//  BodyTrack
//
//  Created by Tom Sugarev on 19/06/2015.
//  Copyright (c) 2015 Tom Sugarex. All rights reserved.
//

import Foundation


extension ProgressPoint
{
    func getImage() -> UIImage?
    {
        
        
        let fileManager = NSFileManager.defaultManager()
        
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        var fullPath = "\(path)/\(imageName)"
        
        if (fileManager.fileExistsAtPath(fullPath))
        {
            println("FILE AVAILABLE");
            
            //Pick Image and Use accordingly
            var imageis: UIImage = UIImage(contentsOfFile: fullPath)!
            
            return imageis
            
        }
        else
        {
            println("FILE NOT AVAILABLE");
            
            return nil
            
        }
    }
    
    func getStats() -> NSString
    {
        var description = ""
        
        if let date = date
        {
            description += "Date: \(date) \n"
        }
        if let measurement = measurement
        {
            description += "Measurement: \(measurement)cm \n"
        }
        if let weight = weight
        {
            description += "Weight: \(weight)kg \n"
        }
        if let bodyFat = bodyFat
        {
            description += "Body fat: \(bodyFat)% \n"
        }
        
        return description
    }
}