//
//  Text+CoreDataProperties.h
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "Text+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Text (CoreDataProperties)

+ (NSFetchRequest<Text *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *data;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, retain) Files *singlefile;

@end

NS_ASSUME_NONNULL_END
