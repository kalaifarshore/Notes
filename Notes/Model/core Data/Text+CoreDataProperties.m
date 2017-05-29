//
//  Text+CoreDataProperties.m
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "Text+CoreDataProperties.h"

@implementation Text (CoreDataProperties)

+ (NSFetchRequest<Text *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Text"];
}

@dynamic data;
@dynamic latitude;
@dynamic longitude;
@dynamic date;
@dynamic singlefile;

@end
