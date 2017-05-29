//
//  FilesView.h
//  Note
//
//  Created by dev11 on 4/5/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilesViewController.h"

@interface FilesView : UIView <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong, setter = setController:)FilesViewController *viewController;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UITableView *filesTableView;
- (IBAction)addFileAction:(id)sender;
- (IBAction)backBtnAction:(id)sender;



@end
