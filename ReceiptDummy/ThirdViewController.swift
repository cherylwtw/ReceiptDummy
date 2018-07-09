//
//  ThirdViewController.swift
//  ImagePicker
//
//  Created by Wenting Wang on 2018-07-07.
//  Copyright © 2018 Wenting Wang. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class ThirdViewController: UIViewController, UISearchBarDelegate {

    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var myMapView: MKMapView!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.didAddSubview(activityIndicator)
        
        // hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        // create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start{ (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("Error")
            }
            else {
                // remove annotation
                let annotations = self.myMapView.annotations
                self.myMapView.removeAnnotations(annotations)
                
                // getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                // create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myMapView.addAnnotation(annotation)
                
                // zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:latitude!, longitude:longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.myMapView.setRegion(region, animated: true)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // setup mapview
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)
//        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
//        mapView.isMyLocationEnabled = true
//        self.view = mapView
//
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        
        }

}
