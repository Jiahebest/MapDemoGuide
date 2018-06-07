//
//  ViewController.swift
//  6.7
//
//  Created by gdcp on 2018/6/7.
//  Copyright © 2018年 gdcp. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController , MKMapViewDelegate{
    var mapView : MKMapView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView = MKMapView(frame: self.view.frame)
        mapView?.mapType = .standard
        mapView?.region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(23.1825, 113.3538), span: MKCoordinateSpanMake(1,1 ))
            mapView?.showsScale = true
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(23.185, 113.3538)
        annotation.title = "GDCP"
        annotation.subtitle = "GuangZhou"
        mapView?.addAnnotation((annotation))
        
        mapView?.delegate = self
        self.view.addSubview(mapView!)
        
        let fromcoor = CLLocationCoordinate2DMake(23.1825, 113.3588)
        let tocoor = CLLocationCoordinate2DMake(24.55, 116.1)
        let fromPlace = MKPlacemark(coordinate: fromcoor)
        let toPlace = MKPlacemark(coordinate: tocoor)
        let fromItem = MKMapItem(placemark: fromPlace)
        let toItem = MKMapItem(placemark: toPlace)
        
        let request = MKDirectionsRequest()
        request.source = fromItem
        request.destination = toItem
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate {(resonse , error) in
            if error != nil{
                print(error!)
            }else {
                let route = resonse?.routes[0]
                let steps = route?.steps
                for step in steps!{
                    let anno = MKPointAnnotation()
                    anno.coordinate=step.polyline.coordinate
                    anno.title = step.instructions
                    anno.subtitle = step.notice
                    self.mapView?.addAnnotation(anno)
                }
            }
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay:MKOverlay) -> MKOverlayRenderer {
        
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.red
        render.lineWidth = 3
        return render
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

