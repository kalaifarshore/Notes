//
//  ContentView.h
//  Note
//
//  Created by dev11 on 4/14/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

@interface ContentView : UIView <UITextViewDelegate, UIImagePickerControllerDelegate> {
    
}

@property (nonatomic, strong, setter = setController:)ContentViewController *viewController;
@property (nonatomic,assign) NSRange cursorPosition;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic)UIImage *currentImage;
@property (nonatomic, strong)NSMutableAttributedString *attributedString;

- (IBAction)backBtnAction:(id)sender;
- (IBAction)takePicture:(id)sender;
- (IBAction)tagBtnAction:(id)sender;



@end
