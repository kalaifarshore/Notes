//
//  FileCell.m
//  Note
//
//  Created by dev11 on 4/12/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "FileCell.h"

@implementation FileCell


-(void)configureCell:(Files *)file
{
    self.fileTitleLabel.text = file.name;
    self.fileIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[FILE_TYPE valueForKey:file.type]]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
