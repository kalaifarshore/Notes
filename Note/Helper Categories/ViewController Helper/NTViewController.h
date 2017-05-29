//
//  NTViewController.h
//  Note
//
//  Created by dev11 on 4/17/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol locationDelegate <NSObject>
@required
-(void)storeLocationWith:(NSString *)latitude and:(NSString *)longitude;
@end

@interface NTViewController : UIViewController

- (void)selectImageFromDevice;
- (void)registerForKeyboardNotifications;
- (void)unRegisterForKeyboardNotifications;
@end
