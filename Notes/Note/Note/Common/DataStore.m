//
//  DataStore.m
//  Note
//
//  Created by dev11 on 4/5/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;
@synthesize managedObjectContext = _managedObjectContext;

- (NSPersistentContainer *)persistentContainer
{
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Note"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

- (NSManagedObjectContext *)managedObjectContext
{
    return self.persistentContainer.viewContext;
}

#pragma mark - Core Data Saving Support

- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


#pragma mark - Data Create Operations

-(void)addFolder:(NSString*)folderName
{
    Files *folder =[NSEntityDescription insertNewObjectForEntityForName:@"Files" inManagedObjectContext:[self managedObjectContext]];
    folder.name = folderName;
    folder.type = @"0";
    [self saveData];
}

-(void)addTextFile:(NSString *)name under:(Files *)folder
{
    Files *file =[NSEntityDescription insertNewObjectForEntityForName:@"Files" inManagedObjectContext:[self managedObjectContext]];
    file.name = name;
    file.type = @"1";
    file.file = folder;
    [self saveData];
}

-(void)addTextDetails:(NSAttributedString *)details for:(Files *)file
{
    Text *textDetail =[NSEntityDescription insertNewObjectForEntityForName:@"Text" inManagedObjectContext:[self managedObjectContext]];
    textDetail.data = details;
    textDetail.singlefile = file;
    textDetail.date = [NSDate date];
    [self saveData];
}

-(void)addLocationDetails:(NSString *)latitude and:(NSString *)longitude for:(Files *)file
{
    Text *textDetail =[NSEntityDescription insertNewObjectForEntityForName:@"Text" inManagedObjectContext:[self managedObjectContext]];
    textDetail.latitude = latitude;
    textDetail.longitude = longitude;
    textDetail.singlefile = file;
    textDetail.date = [NSDate date];
    [self saveData];
}

#pragma mark - Data Featch Opreations

-(NSArray *)fetchFileList:(Files *)folder
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Files" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"file == %@",folder]; // specify your condition (predicate)
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *textList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error]; // execute
    return textList;
}


-(Text*)fetchtextDetails:(Files *)file
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Text" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"singlefile == %@",file]; // specify your condition (predicate)
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    Text *textDetails = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    return textDetails;
}


#pragma mark - Data Update Oprations

-(void)update:(NSString *)name for:(Files *)file
{
    [file setValue:name forKey:@"name"];
    [self saveData];
}

-(void)updateText:(NSObject *)detail for:(Text *)text
{
    [text setValue:detail forKey:@"data"];
    [text setValue:[NSDate date] forKey:@"date"];
    [self saveData];
}

-(void)updateLocation:(NSString *)latitude and:(NSString *)longitude for:(Text *)text
{
    [text setValue:latitude forKey:@"latitude"];
    [text setValue:longitude forKey:@"longitude"];
    [text setValue:[NSDate date] forKey:@"date"];
    [self saveData];
}

#pragma mark - Data Delete oprations

-(void)deleteFile:(id)object
{
    [[self managedObjectContext] deleteObject:object];
    [self saveData];
}

#pragma mark - common function

-(void)saveData
{
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
}


@end
