//
//  ViewController.swift
//  SpotListDemo
//
//  Created by Julian Hulme on 2016/06/08.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var spotList = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.spotList = Spot.spotList()
        
        setupMapView()
        setupTableView()
        
        
        
    }
    
    func setupMapView() {
        
        self.mapView.mapType = .Hybrid
        self.mapView.showsBuildings = true
        self.mapView.addAnnotations(self.spotList as! [MKAnnotation])
        //self.mapView.addannotions
    }
    
    func setupTableView()   {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: "SpotTableViewCell", bundle: nil), forCellReuseIdentifier: "spotTableViewCell")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        return 101
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: TableView Delegate methiods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.spotList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let spot = spotList[indexPath.row] as! Spot

        let cell = tableView.dequeueReusableCellWithIdentifier("spotlist")
        if (cell == nil)    {
            let cell = tableView.dequeueReusableCellWithIdentifier("spotTableViewCell") as! SpotTableViewCell
            cell.cellImage.imageFromUrl(spot.logoURL!)
            cell.label.text = spot.title
            return cell

        }   else    {
            
            return UITableViewCell()
        }
        
        
        
        
//        let cell = UITableViewCell()
//        cell.textLabel?.text = spot.title
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let spot = spotList[indexPath.row]
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let mapCenterCoordinateAfterMove = CLLocationCoordinate2D(latitude: spot.coordinate.latitude,longitude: spot.coordinate.longitude)
        let adjustedRegion = mapView.regionThatFits(MKCoordinateRegionMake(mapCenterCoordinateAfterMove, MKCoordinateSpanMake(0.01, 0.01)))
        mapView.setRegion(adjustedRegion, animated: true)
//        
        mapView.selectAnnotation(spot as! MKAnnotation, animated: true)
    }

}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
