//
//  Files+CoreDataProperties.m
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "Files+CoreDataProperties.h"

@implementation Files (CoreDataProperties)

+ (NSFetchRequest<Files *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Files"];
}

@dynamic name;
@dynamic type;
@dynamic data;
@dynamic file;
@dynamic folder;

@end
