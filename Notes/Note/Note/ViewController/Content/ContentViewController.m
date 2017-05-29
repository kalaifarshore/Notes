//
//  ContentViewController.m
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "ContentViewController.h"
#import "LocationViewController.h"
#import "ContentModel.h"
#import "NoteAttachment.h"
#import "ContentView.h"
#import "UIImage+customImage.h"
#import "AppConstants.h"

@interface ContentViewController ()<locationDelegate>

@property (nonatomic, weak)IBOutlet ContentView *contentView;
@property (nonatomic,strong)ContentModel *contentModel;
@end

@implementation ContentViewController


#pragma mark - View life cycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*Data initialization*/
    if (self.file != nil) {
        self.contentModel = [[ContentModel alloc] init:self.file];
    }
    /*View initialization*/
    [self.contentView setController:self];
    self.navigationController.navigationBarHidden  = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self registerForKeyboardNotifications];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self unRegisterForKeyboardNotifications];
}

#pragma mark - Data functions

-(NSString *)getFileName
{
    return self.file.name;
}

-(NSAttributedString *)getextContent
{
    return [self.contentModel getDetailContent];
}

-(void)storeTextDetails:(NSAttributedString *)data
{
    if (self.contentModel.fileContent != nil) {
        [APPDELEGATE.store updateText:data for:self.contentModel.fileContent];
    } else {
        [APPDELEGATE.store addTextDetails:data for:self.file];
    }
}

-(void)storeLocationDetails:(NSString *)latitude and:(NSString *)longitude
{
    if (self.contentModel.fileContent != nil) {
        [APPDELEGATE.store updateLocation:latitude and:longitude for:self.contentModel.fileContent];
    } else {
        [APPDELEGATE.store addLocationDetails:latitude and:longitude for:self.file];
    }
}

#pragma mark - Cameara & photos custom functions

-(void)showImagePickOptions
{
    [self selectImageFromDevice];
}

- (NSString*)getImageNameWithFolder:(NSString*)imagename
{
    return [NSString stringWithFormat:@"%@_%d_%@",[self getFileName],(arc4random() % 100),imagename];
}

-(void)createImagePathFromSelectedImage:(UIImage*)image andImageName:(NSString*)imageName
{
    imageName = [self getImageNameWithFolder:imageName];
    NSData *imageData = UIImagePNGRepresentation(self.contentView.currentImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:localFilePath atomically:YES];
    [self addImageToTextView:[UIImage imageWithContentsOfFile:localFilePath] andPath:localFilePath andName:imageName];
}

-(BOOL)deleteImageByPath:(id)value
{
    if ([value isKindOfClass:[NoteAttachment class]]) {//Wants to delete attached image
        NoteAttachment *attachment = (NoteAttachment *)value;
        if ([attachment image]) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [documentsPath stringByAppendingPathComponent:[attachment path]];
            if ([fileManager fileExistsAtPath:filePath]){
                NSError *error;
                [fileManager removeItemAtPath:filePath error:&error];
                return YES;
            }
        }
    }
    return NO;
}

-(void)addImageToTextView:(UIImage*)image andPath:(NSString*)path andName:(NSString*)imageName
{
    image = [UIImage imageByScalingProportionallyToSize:self.contentView.currentImage TargetSize:CGSizeMake((self.contentView.frame.size.width - 40), 250)];
    self.contentView.attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentView.contentTextView.attributedText];
    NoteAttachment *textAttachment = [[NoteAttachment alloc] init];
    textAttachment.image = image;
    textAttachment.path = imageName;
    CGFloat oldWidth = textAttachment.image.size.width;
    CGFloat scaleFactor = oldWidth / self.contentView.contentTextView.frame.size.width;
    textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [self.contentView.attributedString insertAttributedString:attrStringWithImage atIndex:self.contentView.cursorPosition.location];
    self.contentView.contentTextView.attributedText = self.contentView.attributedString;
    [self storeTextDetails:self.contentView.attributedString];
}


#pragma mark - custom functions

-(void)showLocationView
{
    LocationViewController *locatioView = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
    locatioView.locationDelegate = self;
    locatioView.latitude = [self.contentModel getLocationLatitude];
    locatioView.longitude = [self.contentModel getLocationLongitude];
    [APPDELEGATE.navigationController pushViewController:locatioView animated:YES];
}


#pragma mark - locationDelegate

-(void)storeLocationWith:(NSString *)latitude and:(NSString *)longitude
{
    [self storeLocationDetails:latitude and:longitude];
}


#pragma mark KeyBoard Notifaction Handler

- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.contentView.contentTextView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
    self.contentView.contentTextView.scrollIndicatorInsets = self.contentView.contentTextView.contentInset;
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    self.contentView.contentTextView.contentInset = UIEdgeInsetsZero;
    self.contentView.contentTextView.scrollIndicatorInsets = UIEdgeInsetsZero;
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)unRegisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                object:nil];
}



@end
