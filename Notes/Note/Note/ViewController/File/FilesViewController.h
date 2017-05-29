//
//  FilesViewController.h
//  Note
//
//  Created by dev11 on 4/5/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileCell.h"
#import "AppConstants.h"
#import "AppDelegate.h"

@interface FilesViewController : UIViewController

@property(nonatomic,strong)Files *folder;

- (NSInteger)getFilesCount;
- (Files *)getFileForIndex:(NSIndexPath *)indexItem;
-(void)addFile:(NSString *)name;
-(void)delteFile:(NSIndexPath *)index;
-(void)showPopup;
-(void)ShowFileView:(Files *)file;
-(void)ShowContentView:(Files *)file;
@end
