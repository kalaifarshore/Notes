//
//  AppDelegate.h
//  Note
//
//  Created by dev11 on 4/3/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"
#import "NTStoryboardIdentifiers.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong, nonatomic)UINavigationController *navigationController;
@property (strong, nonatomic)DataStore *store;

@end

