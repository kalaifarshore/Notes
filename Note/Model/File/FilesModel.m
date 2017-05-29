//
//  FilesModel.m
//  Note
//
//  Created by dev11 on 4/5/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "FilesModel.h"
#import "DataStore.h"
#import "AppDelegate.h"
#import "AppConstants.h"

@implementation FilesModel {
    NSMutableArray *fileList;
}


- (id)init
{
    if (self = [super init]) {
        fileList = [[NSMutableArray alloc] initWithArray:[APPDELEGATE.store fetchFileList:nil]];
    }
    return self;
}

-(id)init:(Files *)withRoot
{
     if (self = [super init]) {
         fileList = [[NSMutableArray alloc] initWithArray:[APPDELEGATE.store fetchFileList:withRoot]];
     }
    return self;
}


- (NSArray *)getFilesList
{
    return fileList;
}

- (NSInteger)getFilesCount
{
    return fileList ? fileList.count : 0;
}

- (Files *)getFileForIndex:(NSIndexPath *)indexItem
{
    if (fileList.count) {
        return [fileList objectAtIndex:indexItem.row];
    }
    return nil;
}

-(void)addFile:(NSString *)name withRoot:(Files *)folder
{
    if (folder != nil) {
        [APPDELEGATE.store addTextFile:name under:folder];
    } else {
        [APPDELEGATE.store addFolder:name];
    }
    [fileList removeAllObjects];
    fileList = [[NSMutableArray alloc] initWithArray:[APPDELEGATE.store fetchFileList:folder]];
}

-(void)deleteFile:(NSIndexPath *)indexPath withRoot:(Files *)folder
{
    [APPDELEGATE.store deleteFile:[fileList objectAtIndex:indexPath.row]];
    [fileList removeAllObjects];
    fileList = [[NSMutableArray alloc] initWithArray:[APPDELEGATE.store fetchFileList:folder]];
}




@end
