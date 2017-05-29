//
//  NTViewController.m
//  Note
//
//  Created by dev11 on 4/17/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "NTViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "AppConstants.h"
#import "AppDelegate.h"



@interface NTViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) UIImagePickerController *imagePickerController;
@end

@implementation NTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Camera Control

- (void)selectImageFromDevice
{
    if (APPDELEGATE.navigationController.topViewController) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Camera", @"Select from Library", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [actionSheet showInView:APPDELEGATE.navigationController.topViewController.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex) {
        case 0: {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self checkCameraAccessState];
            }else{
                
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Your device has no camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [myAlertView show];
            }
        }
            break;
        case 1: {
            [self checkPhotoLibraryAccessState];
        }
        default:
            break;
    }
}

#pragma mark check Camera Access avail or not

- (void)checkCameraAccessState
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        [self showcamera];
    } else if(authStatus == AVAuthorizationStatusDenied){
        // denied
        [self cameraDenied:@"camera"];
    } else if(authStatus == AVAuthorizationStatusRestricted){
        // restricted, normally won't happen
        [self cameraDenied:@"camera"];
    } else if(authStatus == AVAuthorizationStatusNotDetermined){
        // not determined?!
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                [self showcamera];
            }
        }];
    }
}

#pragma mark check Photo Library Access avail or not
- (void)checkPhotoLibraryAccessState
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") ) {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        
        if (status == PHAuthorizationStatusAuthorized) {
            // Access has been granted.
            [self openLibrary];
        }
        
        else if (status == PHAuthorizationStatusDenied) {
            // Access has been denied.
            [self cameraDenied:@"library"];
        }
        
        else if (status == PHAuthorizationStatusNotDetermined) {
            // Access has not been determined.
            
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    // Access has been granted.
                    [self openLibrary];
                }
            }];
        }
        
        else if (status == PHAuthorizationStatusRestricted) {
            // Restricted access - normally won't happen.
            [self cameraDenied:@"library"];
        }
    }else{
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        
        if(status == ALAuthorizationStatusNotDetermined) {
            // do your logic
            [self openLibrary];
        } else if(status == ALAuthorizationStatusRestricted){
            // denied
            [self cameraDenied:@"library"];
        } else if(status == ALAuthorizationStatusDenied){
            // restricted, normally won't happen
            [self cameraDenied:@"library"];
        } else if(status == ALAuthorizationStatusAuthorized){
            // not determined?!
            [self openLibrary];
        } else {
            // impossible, unknown authorization status
        }
    }
}

#pragma mark alert control if camera or library access denied

- (void)cameraDenied:(NSString*)isCamera
{
    if ([isCamera  isEqual: @"camera"]) {
        NSLog(@"MSG_CAMERA_PERMISSION %@",[MSG_CAMERA_PERMISSION valueForKey:@"content"]);
        
    }else{
        NSLog(@"MSG_PHOTO_PERMISSION %@",[MSG_PHOTO_PERMISSION valueForKey:@"content"]);
    }
}

- (void)openLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = APPDELEGATE.navigationController.topViewController.view;
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    picker.allowsEditing = YES;
    self.imagePickerController = picker;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}
- (void)showcamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate =  APPDELEGATE.navigationController.topViewController.view;
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    picker.allowsEditing = YES;
    self.imagePickerController = picker;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


@end
