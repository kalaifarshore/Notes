//
//  DataStore.h
//  Note
//
//  Created by dev11 on 4/5/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Files+CoreDataClass.h"
#import "Text+CoreDataClass.h"

@interface DataStore : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;
#pragma mark - Data Create Operations
-(void)addFolder:(NSString*)folderName;
-(void)addTextFile:(NSString *)name under:(Files *)folder;
-(void)addTextDetails:(NSAttributedString *)details for:(Files *)file;
-(void)addLocationDetails:(NSString *)latitude and:(NSString *)longitude for:(Files *)file;
#pragma mark - Data Featch Opreations
-(NSArray *)fetchFileList:(Files *)folder;
-(Text*)fetchtextDetails:(Files *)file;
#pragma mark - Data Update Oprations
-(void)update:(NSString *)name for:(Files *)file;
-(void)updateText:(NSObject *)detail for:(Text *)text;
-(void)updateLocation:(NSString *)latitude and:(NSString *)longitude for:(Text *)text;
#pragma mark - Data Delete oprations
-(void)deleteFile:(id)object;
@end
