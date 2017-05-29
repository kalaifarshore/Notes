//
//  LocationView.m
//  Note
//
//  Created by dev11 on 5/16/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "LocationView.h"
#import "AppConstants.h"
#import "SearchTableCell.h"


static NSString *commonIdentifier = @"LocationSearchCommon";
static NSString *locationCellIdentifier = @"SearchTableCell";

@interface LocationView () <UISearchBarDelegate>{
IBOutlet SearchTableCell *searchCell;
}
@end


@implementation LocationView

- (void)setController:(LocationViewController *)viewController
{
    _viewController = viewController;
    self.locationsArray = [[NSMutableArray alloc] init];
    self.mapView.delegate = self;
    self.mapView.zoomEnabled = YES;
    self.locationTableView.hidden = YES;
    [self.viewController updateuserlocation];
}

#pragma mark Map - location manager delegates

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        if ([CLLocationManager locationServicesEnabled]) {
            
            if ([self.viewController.latitude isEqualToString:@""] || [self.viewController.longitude isEqualToString:@""]) {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [self.locationManager startUpdatingLocation];
            self.mapView.showsUserLocation = YES;
            } else {
                [self.locationManager stopUpdatingLocation];
            }
        }
    }
}

#pragma mark - Map view delegates

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (self.firstLoad ) {
        self.firstLoad = NO;
        [self.viewController zoomIn:nil];
        self.viewController.latitude = [NSString stringWithFormat:@"%f", userLocation.coordinate.latitude];
        self.viewController.longitude = [NSString stringWithFormat:@"%f", userLocation.coordinate.longitude];
        [self.viewController setAnnotationToMapView];
    }else {
        self.firstLoad = NO;
    }
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *aV;
    for (aV in views) {
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            MKAnnotationView* annotationView = aV;
            annotationView.canShowCallout = YES;
        }
    }
}


#pragma mark - Table view data source & delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locationsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableCell *cell = (SearchTableCell*)[self.locationTableView dequeueReusableCellWithIdentifier:locationCellIdentifier];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"SearchTableCell" owner:self options:nil];
        cell = (SearchTableCell*)searchCell;
    }
    MKMapItem *item = [self.locationsArray objectAtIndex:indexPath.row];
    cell.locationIconView.hidden = NO;
    cell.locationLabel.text = item.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self endEditing:YES];
    MKMapItem *item = self.locationsArray[indexPath.row];
    self.locationSearchBar.text = item.placemark.title;
    CLLocationCoordinate2D coord = item.placemark.location.coordinate;
    self.viewController.latitude = [NSString stringWithFormat:@"%f",coord.latitude];
    self.viewController.longitude = [NSString stringWithFormat:@"%f",coord.longitude];
    [self.viewController setAnnotationToMapView];
    self.locationTableView.hidden = YES;
}

#pragma mark - Search Bar Implementation

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        [self.locationsArray removeAllObjects];
        self.locationTableView.hidden = YES;
    }
    [self.viewController performLocationSearch];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.viewController performLocationSearch];
}


#pragma mark - IBoutlet actions

- (IBAction)backBtnAction:(id)sender
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
@end
