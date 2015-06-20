//
//  ProgressPointDetailTableViewController.swift
//  BodyTrack
//
//  Created by Tom Sugarev on 19/06/2015.
//  Copyright (c) 2015 Tom Sugarex. All rights reserved.
//

import UIKit

class ProgressPointDetailTableViewController: UITableViewController, UIAlertViewDelegate {

    enum TableViewCell: Int
    {
        case Date
        case Measurement
        case BodyWeight
        case BodyFat
        case Count
    }
    
    var progressPoint: ProgressPoint?
    var selectedStat : TableViewCell.RawValue?
    
    @IBOutlet var imageView: UIImageView!
    
    let TableViewCellIdentifier = "Cell"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let progressPoint = self.progressPoint
        {
            if let imageView = self.imageView
            {
                if let image = self.progressPoint?.getImage()
                {
                    imageView.image = image
                }
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return TableViewCell.Count.rawValue
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        switch indexPath.row
        {
        case TableViewCell.Date.rawValue:
            cell.textLabel?.text = "Date"
            if let date = self.progressPoint?.date
            {
                var dateformatter = NSDateFormatter()
                dateformatter.timeStyle = NSDateFormatterStyle.NoStyle
                dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
                dateformatter.dateFormat = "dd MMM yyyy"
                cell.detailTextLabel?.text = dateformatter.stringFromDate(date)
            }
            
            break
            
        case TableViewCell.Measurement.rawValue:
            cell.textLabel?.text = "Measurement (cm)"
            if let measurement = self.progressPoint?.measurement
            {
                cell.detailTextLabel?.text = "\(measurement) cm"
            }
            break
        case TableViewCell.BodyWeight.rawValue:
            cell.textLabel?.text = "Body Weight (kg)"
            if let weight = self.progressPoint?.weight
            {
                cell.detailTextLabel?.text = "\(weight) kg"
            }
            break
        case TableViewCell.BodyFat.rawValue:
            cell.textLabel?.text = "Body Fat (%)"
            if let bodyFat = self.progressPoint?.bodyFat
            {
                cell.detailTextLabel?.text = "\(bodyFat) %"
            }
            break
        default:
            break
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var alertView = UIAlertView(title: "", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Save")
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alertView.textFieldAtIndex(0)?.keyboardType = UIKeyboardType.DecimalPad
        
        switch indexPath.row
        {
        case TableViewCell.Date.rawValue:
            
        return
            
        case TableViewCell.Measurement.rawValue:
            
            alertView.title = "Edit measurement"
            alertView.message = "Enter measurement"
            self.selectedStat = TableViewCell.Measurement.rawValue
            break
            
        case TableViewCell.BodyWeight.rawValue:
            alertView.title = "Edit Body Weight"
            alertView.message = "Enter Body Weight"
            self.selectedStat = TableViewCell.BodyWeight.rawValue
            break
            
        case TableViewCell.BodyFat.rawValue:
            alertView.title = "Edit Body Fat"
            alertView.message = "Enter Body Fat"
            self.selectedStat = TableViewCell.BodyFat.rawValue
            break
            
        default:
            break
        
        }
        
        alertView.show()
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        
        if buttonIndex == 1
        {
            var text = alertView.textFieldAtIndex(0)?.text
            switch self.selectedStat!
            {
            case TableViewCell.Measurement.rawValue:
                
                self.progressPoint?.measurement = text?.toInt()
                break
                
            case TableViewCell.BodyWeight.rawValue:
                self.progressPoint?.weight = text?.toInt()
                break
            case TableViewCell.BodyFat.rawValue:
                self.progressPoint?.bodyFat = text?.toInt()
                break
            default:
                break
            }
            self.tableView.reloadData()
        }
    }
}
