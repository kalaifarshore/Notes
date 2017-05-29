//
//  FilesViewController.m
//  Note
//
//  Created by dev11 on 4/5/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import "FilesViewController.h"
#import "FilesModel.h"
#import "FilesView.h"
#import "ContentViewController.h"

@interface FilesViewController ()

@property (nonatomic, weak)IBOutlet FilesView *fileView;
@property (nonatomic,strong)FilesModel *fileModel;

@end

@implementation FilesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*Model initialization*/
    
    if (self.folder != nil) { //sub directory text files
        self.fileModel = [[FilesModel alloc] init:self.folder];
    }else { //Load root directory files
        self.fileModel  = [[FilesModel alloc] init];
    }
    /*View initialization */
    [self.fileView setController:self];
    self.navigationController.navigationBarHidden  = YES;
    
}


#pragma mark - model custom messges

-(void)addFile:(NSString *)name
{
    [self.fileModel addFile:name withRoot:self.folder];
    [self.fileView.filesTableView reloadData];
}

-(void)delteFile:(NSIndexPath *)index
{
    [self.fileModel deleteFile:index withRoot:self.folder];
    [self.fileView.filesTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSInteger)getFilesCount
{
    return [self.fileModel getFilesCount];
}

- (Files *)getFileForIndex:(NSIndexPath *)indexItem
{
    return [self.fileModel getFileForIndex:indexItem];
}


#pragma mark - custom messges

-(void)showPopup
{
    NSDictionary *details = (self.folder != nil) ? TEXT_POPUP : FOLDER_POPUP;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[details valueForKey:@"title"]
                                                    message:[details valueForKey:@"placeHolder"]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Add", nil];
    alert.tag = (NSInteger)[details valueForKey:@"tag"];
    alert.delegate = self.fileView;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)ShowFileView:(Files *)file
{
    UIStoryboard *landStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FilesViewController *textView = (FilesViewController*)[landStoryboard instantiateViewControllerWithIdentifier: NTFilesViewController];
    textView.folder = file;
    [APPDELEGATE.navigationController pushViewController:textView animated:YES];
}

-(void)ShowContentView:(Files *)file
{
    UIStoryboard *landStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ContentViewController *contentView = (ContentViewController*)[landStoryboard instantiateViewControllerWithIdentifier: NTContentViewController];
    contentView.file = file;
    [APPDELEGATE.navigationController pushViewController:contentView animated:YES];
}


@end
