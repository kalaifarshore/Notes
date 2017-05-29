//
//  ContentViewController.h
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NTViewController.h"

@interface ContentViewController : NTViewController <UIImagePickerControllerDelegate>

@property(nonatomic,strong)Files *file;

-(NSString *)getFileName;
-(NSAttributedString *)getextContent;
-(void)storeTextDetails:(NSAttributedString *)data;

-(void)showImagePickOptions;
-(void)createImagePathFromSelectedImage:(UIImage*)image andImageName:(NSString*)imageName;
-(BOOL)deleteImageByPath:(id)value;
-(void)showLocationView;

@end
