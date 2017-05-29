//
//  AppConstants.h
//  Note
//
//  Created by dev11 on 4/5/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE6 ([[UIScreen mainScreen] bounds].size.height == 667)
#define IS_IPHONE6n ([[UIScreen mainScreen] bounds].size.height == 736)

#define APPDELEGATE ((AppDelegate*)[UIApplication sharedApplication].delegate)
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESSER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define MAP_ZOOM_SIZE    2000
#define FILE_TYPE @{@"0":@"Folder", @"1":@"File"}
#define FOLDER_POPUP @{@"title":@"New Folder", @"PlaceHolder":@"Enter a New Folder Name", @"tag":@"0"}
#define TEXT_POPUP @{@"title":@"New File", @"PlaceHolder":@"Enter a New text Name", @"tag":@"1"}

#define MSG_CAMERA_PERMISSION     @{@"title":@"Request Authorization", @"content": @"It looks like your privacy settings are preventing us from accessing your camera, you can Turn on the Camera in the Settings app."}
#define MSG_PHOTO_PERMISSION      @{@"title":@"Request Authorization", @"content": @"It looks like your privacy settings are preventing us from accessing your Photos library,  you can Turn on the Photo library in the Settings app."}
#define MSG_LOCATION_PERMISSION   @{@"title":@"Request Authorization", @"content": @"Notes needs access to your location. Please turn on Location Service in the Settings app."}


#endif /* AppConstants_h */
