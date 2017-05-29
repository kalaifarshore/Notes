//
//  FileCell.h
//  Note
//
//  Created by dev11 on 4/12/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Files+CoreDataClass.h"
#import "AppConstants.h"

@interface FileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *fileIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *fileTitleLabel;
-(void)configureCell:(Files *)file;

@end
