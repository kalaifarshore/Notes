//
//  ContentModel.h
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AppConstants.h"

@interface ContentModel : NSObject

@property (nonatomic, strong)Text *fileContent;

- (id)init:(Files *)file;
-(NSMutableAttributedString *)getDetailContent;
-(NSString *)getLocationLatitude;
-(NSString *)getLocationLongitude;
@end
