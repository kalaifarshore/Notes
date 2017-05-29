//
//  ContentModel.m
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel

- (id)init:(Files *)file
{
    if (self = [super init]) {
        self.fileContent = [APPDELEGATE.store fetchtextDetails:file];
    }
    return self;
}

-(NSMutableAttributedString *)getDetailContent
{
    return (id)self.fileContent.data;
}

-(NSString *)getLocationLatitude
{
    return (self.fileContent.latitude) ? self.fileContent.latitude : @""; //28.7041
}

-(NSString *)getLocationLongitude
{
    return (self.fileContent.longitude) ? self.fileContent.longitude : @""; //77.1025
}


@end
