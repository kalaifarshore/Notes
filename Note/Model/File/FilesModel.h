//
//  FilesModel.h
//  Note
//
//  Created by dev11 on 4/5/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Files+CoreDataClass.h"

@interface FilesModel : NSObject

- (id)init;
-(id)init:(Files *)withRoot;
- (NSArray *)getFilesList;
- (NSInteger)getFilesCount;
- (Files *)getFileForIndex:(NSIndexPath *)indexItem;
-(void)addFile:(NSString *)name withRoot:(Files *)folder;
-(void)deleteFile:(NSIndexPath *)object withRoot:(Files *)folder;

@end
