//
//  ContentView.m
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

- (void)setController:(ContentViewController *)viewController
{
     _viewController = viewController;
    self.titleLabel.text = [self.viewController getFileName];
    self.contentTextView.attributedText = [self.viewController getextContent];
}

#pragma mark - Text View delegte

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self performSelector:@selector(placeCursorAtEnd:) withObject:textView afterDelay:0.01];
}

- (void)placeCursorAtEnd:(UITextView *)textview
{
    NSUInteger length = textview.text.length;
    textview.selectedRange = NSMakeRange(length, 0);
}

-(void)textViewDidChange:(UITextView *)textView
{
    [self.viewController storeTextDetails:textView.attributedText];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    [self.contentTextView.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.contentTextView.attributedText.length) options:0 usingBlock:^(id value, NSRange imageRange, BOOL *stop){
            if (NSEqualRanges(range, imageRange) && [text isEqualToString:@""]){
                if(![self.viewController deleteImageByPath:value]) {
                    self.cursorPosition = range;
                }
            }
    }];
    
    return YES;
}


#pragma mark - Image Picker Delegate functions

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    // Picking Image from Camera/ Library
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentImage = info[UIImagePickerControllerEditedImage];
        // Firstly get the picked image's file URL.
        NSURL *imageFileURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        // Then get the file name.
        NSString *imageName = [imageFileURL lastPathComponent];
        if (!self.currentImage) return;
        [self.viewController createImagePathFromSelectedImage:self.currentImage andImageName:imageName];
    });
}

#pragma mark - IBOutlet Action

- (IBAction)backBtnAction:(id)sender
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (IBAction)takePicture:(id)sender
{
    self.cursorPosition = [self.contentTextView selectedRange];
    [self endEditing:YES];
    [self.viewController showImagePickOptions];
}

- (IBAction)tagBtnAction:(id)sender
{
    [self.viewController showLocationView];
}

@end
