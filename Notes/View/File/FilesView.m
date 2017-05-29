//
//  FilesView.m
//  Note
//
//  Created by dev11 on 4/5/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "FilesView.h"
#import "FileCell.h"


@implementation FilesView {
    IBOutlet FileCell *fileCell;
}

- (void)setController:(FilesViewController *)viewController
{
    _viewController = viewController;
    if(self.viewController.folder != nil) {
        self.titleLbl.text = self.viewController.folder.name;
        [self.addButton setImage:[UIImage imageNamed:@"AddText"] forState:UIControlStateNormal];
        [self.backButton setHidden:NO];
    }else {
        [self.backButton setHidden:YES];
    }
}

#pragma mark - tableview datasource & delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewController getFilesCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileCell *cell = (FileCell*)[self.filesTableView dequeueReusableCellWithIdentifier:NTFileCellIdentifier];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"FileCell" owner:self options:nil];
        cell = (FileCell*)fileCell;
    }
    [cell configureCell:[self.viewController getFileForIndex:indexPath]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewController.folder != nil) {
        [self.viewController ShowContentView:[self.viewController getFileForIndex:indexPath]];
    } else {
        [self.viewController ShowFileView:[self.viewController getFileForIndex:indexPath]];
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewController delteFile:indexPath];
        
    }
}


#pragma mark - Alert view delegate methods

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        [self.viewController addFile:textField.text];
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    return [alertView textFieldAtIndex:0].text.length > 0;
}

#pragma mark - IBoutlet Action

- (IBAction)addFileAction:(id)sender
{
    [self.viewController showPopup];
}

- (IBAction)backBtnAction:(id)sender
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}




@end
