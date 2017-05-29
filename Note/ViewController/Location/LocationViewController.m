//
//  LocationViewController.m
//  Note
//
//  Created by dev11 on 5/16/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "LocationViewController.h"
#import "AppConstants.h"
#import "LocationView.h"

@interface LocationViewController () {
    CLLocationCoordinate2D currentCooridnate;
}

@property (nonatomic, weak)IBOutlet LocationView *locationView;
@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinate;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*View initialization*/
    [self.locationView setController:self];
    /*update map location */
    if (self.latitude.length > 0 && self.longitude.length > 0) {
        [self setAnnotationToMapView];
    }
}

#pragma mark - Map view custom functions

-(void)updateuserlocation
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    self.locationView.firstLoad = YES;
    if ([self checkLocationServiceEnable]) {
        self.locationView.locationManager = [[CLLocationManager alloc] init];
        self.locationView.locationManager.delegate = self.locationView;
        if (status == kCLAuthorizationStatusNotDetermined) {
            [self.locationView.locationManager requestWhenInUseAuthorization];
        }
    }
}


-(BOOL)checkLocationServiceEnable
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied) {
        NSDictionary *details = MSG_LOCATION_PERMISSION;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[details valueForKey:@"title"] message:[details valueForKey:@"content"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alert show];
        return NO;
    }else {
        return YES;
    }
}

-(void)setAnnotationToMapView
{
    
    /*remove old annotations*/
    [self.locationView.mapView removeAnnotations:self.locationView.mapView.annotations];
    currentCooridnate.latitude = [self.latitude floatValue];
    currentCooridnate.longitude =  [self.longitude floatValue];
    /*add new anotation*/
    MKPointAnnotation *commonAnnotation = [[MKPointAnnotation alloc] init];
    commonAnnotation.coordinate = currentCooridnate;
    [self.locationView.mapView addAnnotation:commonAnnotation];
    [self changeRegionTo:2000];
    
    /*Save location details into core data*/
    if ([self.locationDelegate respondsToSelector:@selector(storeLocationWith:and:)]) {
        [self.locationDelegate storeLocationWith:self.latitude and:self.longitude];
    }
}

-(void)zoomIn:(id)sender
{
    MKUserLocation *userLocation = self.locationView.mapView.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, MAP_ZOOM_SIZE, MAP_ZOOM_SIZE);
    [self.locationView.mapView setCenterCoordinate:self.locationView.mapView.userLocation.location.coordinate animated:YES];
    [self.locationView.mapView setRegion:region animated:YES];
}

- (void)changeRegionTo:(NSUInteger)size
{
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(currentCooridnate, size, size);
    [self.locationView.mapView setRegion:newRegion animated:YES];
}

#pragma mark - Local Serach Function

- (void)performLocationSearch
{
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.locationView.locationSearchBar.text;
    MKCoordinateRegion rgn = MKCoordinateRegionMakeWithDistance(currentCooridnate, 1, 1);
    request.region = rgn;
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        [self.locationView.locationsArray removeAllObjects];
        for(MKMapItem *item in response.mapItems) {
          [self.locationView.locationsArray addObject:item];
        }
        [self reloadLoctionTableView];
    }];
}

- (void)reloadLoctionTableView
{
    if (self.locationView.locationsArray.count > 0) {
        self.locationView.locationTableView.hidden = NO;
    }
    [self.locationView.locationTableView reloadData];
}


@end
