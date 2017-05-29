//
//  LocationViewController.h
//  Note
//
//  Created by dev11 on 5/16/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import "NTViewController.h"

@interface LocationViewController : NTViewController

@property (nonatomic, strong)NSString *latitude;
@property (nonatomic,strong)NSString *longitude;
@property (nonatomic, weak)id <locationDelegate> locationDelegate;

-(void)updateuserlocation;
-(void)setAnnotationToMapView;
-(void)zoomIn:(id)sender;
- (void)performLocationSearch;

@end
