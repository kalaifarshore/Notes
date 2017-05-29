//
//  LocationView.h
//  Note
//
//  Created by dev11 on 5/16/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationViewController.h"

@interface LocationView : UIView <MKMapViewDelegate, CLLocationManagerDelegate>


@property (nonatomic, strong, setter=setController:)LocationViewController *viewController;
@property (weak, nonatomic) IBOutlet UISearchBar *locationSearchBar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *locationTableView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic,assign) BOOL firstLoad;
@property (nonatomic,strong)NSMutableArray *locationsArray;

- (IBAction)backBtnAction:(id)sender;



@end
