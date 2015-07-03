//
//  ProgressPointCollectionViewHelper.swift
//  BodyTrack
//
//  Created by Tom Sugarex on 18/06/2015.
//  Copyright (c) 2015 Tom Sugarex. All rights reserved.
//

import UIKit

class ProgressPointCollectionViewHelper: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let SegueToCompareTabBar : String = "GoToCompareSegueId"
    let reuseIdentifier = "Cell"
    let ProgressPointSegueId = "showProgressPointId"
    let bodyReuseIdentifier = "BodyCollectionViewCellId"
    let addReuseIdentifier = "AddCollectionViewId"
    var progressPoints = [ProgressPoint]()
    var selectMode : Bool = false
    var selectedProgressPoints = [ProgressPoint]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var photoSelectionCollectionViewController: PhotoSelectionCollectionViewController!
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        println(progressPoints.count)
        return progressPoints.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        if (indexPath.row == progressPoints.count)
        {
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(addReuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
            
                cell.layer.borderColor = UIColor.blackColor().CGColor
                cell.layer.borderWidth = 1.0
                
                return cell
        }
        else
        {
            var progressPoint: ProgressPoint = progressPoints[indexPath.row]
            var progressCollection = progressPoint.progressCollection as! ProgressCollection
            
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(bodyReuseIdentifier, forIndexPath: indexPath) as! ProgressPointCollectionViewCell
            
            cell.selectedBackgroundView = UIView(frame: cell.bounds)
            cell.selectedBackgroundView.backgroundColor = UIColor.blueColor()
            
            if let imageView = cell.progressPicImageView, image = progressPoint.getImage()
            {
                imageView.image = image
            }
            var dateformatter = NSDateFormatter()
            dateformatter.timeStyle = NSDateFormatterStyle.NoStyle
            dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
            dateformatter.dateFormat = "dd MMM yyyy"
            
            cell.date.text = dateformatter.stringFromDate(progressPoint.date)
                    
            cell.contentView.frame = cell.bounds
            cell.contentView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
                
            cell.layer.borderColor = UIColor(rgba: progressCollection.colour).CGColor
            cell.layer.borderWidth = 1.0
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(16, 16, 8, 16)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let padding:CGFloat = 8 * 3
        let side:CGFloat = CGRectGetWidth(collectionView.frame) / 2
        let sideMinusPadding:CGFloat = side - padding
        return CGSizeMake(sideMinusPadding, sideMinusPadding + 44)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if (indexPath.row == progressPoints.count)
        {
            photoSelectionCollectionViewController.showActionSheet()
        }
        else if selectMode
        {
            selectedProgressPoints.append(progressPoints[indexPath.row])
            var cell = collectionView.cellForItemAtIndexPath(indexPath) as! ProgressPointCollectionViewCell
            cell.layer.borderWidth = 6

            
            if selectedProgressPoints.count == 2
            {
                photoSelectionCollectionViewController.progressPointsToCompare = ProgressPointsToCompare(firstProgressPoint: selectedProgressPoints.first!, secondProgressPoint: selectedProgressPoints.last!)
                deselectAllCellsInCollectionView()
                photoSelectionCollectionViewController.performSegueWithIdentifier(SegueToCompareTabBar, sender: photoSelectionCollectionViewController)
            }
        }
        else
        {
            var cell = collectionView.cellForItemAtIndexPath(indexPath) as! ProgressPointCollectionViewCell
            cell.selected = false
            photoSelectionCollectionViewController.selectedProgressPoint = progressPoints[indexPath.row]
            photoSelectionCollectionViewController.performSegueWithIdentifier("ShowProgressPointDetailId", sender: photoSelectionCollectionViewController)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row != progressPoints.count
        {
            var progressPoint = progressPoints[indexPath.row]
            
            var index = find(selectedProgressPoints, progressPoint)
            
            if let index = index
            {
                selectedProgressPoints.removeAtIndex(index)
            }
            
            
            var cell = collectionView.cellForItemAtIndexPath(indexPath) as! ProgressPointCollectionViewCell
            cell.layer.borderWidth = 1
        }
    }
    
    func deselectAllCellsInCollectionView()
    {
        for indexPath in collectionView.indexPathsForSelectedItems()
        {
            collectionView(collectionView, didDeselectItemAtIndexPath: indexPath as! NSIndexPath)
        }
    }
}
