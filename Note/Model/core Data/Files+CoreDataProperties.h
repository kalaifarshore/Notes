//
//  Files+CoreDataProperties.h
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "Files+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Files (CoreDataProperties)

+ (NSFetchRequest<Files *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, retain) Text *data;
@property (nullable, nonatomic, retain) Files *file;
@property (nullable, nonatomic, retain) NSSet<Files *> *folder;

@end

@interface Files (CoreDataGeneratedAccessors)

- (void)addFolderObject:(Files *)value;
- (void)removeFolderObject:(Files *)value;
- (void)addFolder:(NSSet<Files *> *)values;
- (void)removeFolder:(NSSet<Files *> *)values;

@end

NS_ASSUME_NONNULL_END
