//
//  RootViewController.m
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "WriteDiaryViewController.h"
#import "DiaryModel.h"
#import "DiaryListViewController.h"
#import "UITool.h"
#import "IOSUtil.h"
#import "DiaryConstant.h"
#import "DataTool.h"


@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"PeaceDiary";
    

    NSString* pwd = [DataTool getPassword];
    if([pwd length]<=0)
    {    
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"SetPwd" style:UIBarButtonItemStylePlain target:self action:@selector(setDiaryPwd:)] autorelease];
    }
    else
    {
            self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"RemovePwd" style:UIBarButtonItemStylePlain target:self action:@selector(dismissPwd:)] autorelease];
        
         [self showRequirePwdView];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"write diary";
    }
    else if(indexPath.row == 1)
    {
        cell.textLabel.text = @"read diary";
    }
    // Configure the cell.
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
    if(indexPath.row == 0)
    {
        WriteDiaryViewController* wdvc = [[WriteDiaryViewController alloc] init];
        [self.navigationController pushViewController:wdvc animated:YES];
        [wdvc release];
    }
    else if(indexPath.row == 1)
    {
       
        NSArray* diarys = [DiaryModel getDiaryModelFromDB];
        NSLog(@"diarys:%@",diarys);
        DiaryListViewController* list = [[DiaryListViewController alloc] initWithDiaryArray:diarys];
        [self.navigationController pushViewController:list animated:YES];
        [list release];
    }
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) setDiaryPwd:(id)sender;
{
//    [UITool showAlertWithTitle:@"Alert" withMsg:@"Need setup a pwd" WithDelegate:nil];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kSetupDiaryPassword
                                                    message:@"\n\n\n" 
                                                   delegate:self 
                                          cancelButtonTitle:kCancelButtonTitle 
                                          otherButtonTitles:kOKButtonTitle , nil];
    
    UITextField *inputPwd = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
    inputPwd.placeholder = @"input your password!";
    [inputPwd setBackgroundColor:[UIColor clearColor]];
    inputPwd.borderStyle = UITextBorderStyleRoundedRect;
    inputPwd.delegate = self;
    inputPwd.tag = kInputPwdTag;
    inputPwd.secureTextEntry = YES;
    [alert addSubview:inputPwd];
    [inputPwd release];
    
    UITextField *inputPwdCheck = [[UITextField alloc] initWithFrame:CGRectMake(12,80, 260, 25)];
    inputPwdCheck.placeholder = @"input your password again!";
    [inputPwdCheck setBackgroundColor:[UIColor clearColor]];
    inputPwdCheck.borderStyle = UITextBorderStyleRoundedRect;
    inputPwdCheck.delegate = self;
    inputPwdCheck.secureTextEntry = YES;
    inputPwdCheck.tag =  kInputCheckPwdTag;
    [alert addSubview:inputPwdCheck];
    [inputPwdCheck release];
    
    if([IOSUtil isPreIOS4])
    {
        CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 100);
        [alert setTransform:myTransform];
    }
    
    [alert show];
    [alert release];


}

- (void) dismissPwd:(id)sender
{
    [self showAlertWithTextFieldWithTitle:kPassworkdVerify];
}

- (void) showRequirePwdView
{
    [self showAlertWithTextFieldWithTitle:kDiaryNeedPassworkd];
}

- (void) showAlertWithTextFieldWithTitle:(NSString*)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:@"\n\n" 
                                                   delegate: self
                                          cancelButtonTitle:kCancelButtonTitle
                                          otherButtonTitles:kOKButtonTitle, nil];
    
    UITextField *inputPwd = [[UITextField alloc] initWithFrame:CGRectMake(12, 55, 260, 25)];
    inputPwd.placeholder = @"input your password!";
    [inputPwd setBackgroundColor:[UIColor clearColor]];
    inputPwd.borderStyle = UITextBorderStyleRoundedRect;
    inputPwd.delegate = self;
    inputPwd.secureTextEntry = YES;
    inputPwd.tag = kInputPwdTag;
    [alert addSubview:inputPwd];
    [inputPwd becomeFirstResponder];
    [inputPwd release];
    
    if([IOSUtil isPreIOS4])
    {
        CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 100);
        [alert setTransform:myTransform];
    }
    
    [alert show];
    [alert release];
}

#pragma mark-
#pragma mark--- UITextFieldDelegate Methods---


#pragma mark-
#pragma mark--- UIAlertView Methods---

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString* alertTitle = alertView.title;
    if([alertTitle isEqualToString:kDiaryNeedPassworkd])
    {
        UIView* subView = [alertView viewWithTag:kInputPwdTag];
        if([subView isKindOfClass:[UITextField class]])
        {
            UITextField* tf = (UITextField*)subView;
            [tf resignFirstResponder];
        }
    }
    else if([alertTitle isEqualToString:kSetupDiaryPassword])
    {
        UIView* subView = [alertView viewWithTag:kInputPwdTag];
        if([subView isKindOfClass:[UITextField class]])
        {
            UITextField* tf = (UITextField*)subView;
            [tf resignFirstResponder];
        }
        
        subView = [alertView viewWithTag:kInputCheckPwdTag];
        if([subView isKindOfClass:[UITextField class]])
        {
            UITextField* tf = (UITextField*)subView;
            [tf resignFirstResponder];
        }
    }
    else if([alertTitle isEqualToString:kPassworkdVerify]) 
    {
        UIView* subView = [alertView viewWithTag:kInputPwdTag];
        if([subView isKindOfClass:[UITextField class]])
        {
            UITextField* tf = (UITextField*)subView;
            [tf resignFirstResponder];
        }
    }   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* alertTitle = alertView.title;
    NSString* buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if([alertTitle isEqualToString:kDiaryNeedPassworkd])
    {
        if([buttonTitle isEqualToString:kOKButtonTitle])
        {
            NSString* password=nil;
            UIView* subView = [alertView viewWithTag:kInputPwdTag];
            if([subView isKindOfClass:[UITextField class]])
            {
                UITextField* tf = (UITextField*)subView;
                [tf resignFirstResponder];
                password= [tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            if(![password isEqualToString:[DataTool getPassword]])
            {
                [self showRequirePwdView];
            }
        }
        else
        {
            [self showRequirePwdView];
        }
    }
    else if([alertTitle isEqualToString:kSetupDiaryPassword])
    {
        if([buttonTitle isEqualToString:kOKButtonTitle])
        {
            NSString* password=nil;
            NSString* checkPassword=nil;
            UIView* subView = [alertView viewWithTag:kInputPwdTag];
            if([subView isKindOfClass:[UITextField class]])
            {
                UITextField* tf = (UITextField*)subView;
                [tf resignFirstResponder];
                password= [tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            
            subView = [alertView viewWithTag:kInputCheckPwdTag];
            if([subView isKindOfClass:[UITextField class]])
            {
                UITextField* tf = (UITextField*)subView;
                [tf resignFirstResponder];
                checkPassword=[tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            }
            if([password isEqualToString:checkPassword])
            {
                if(![DataTool savePassword:password])
                {
                    [UITool showAlertWithTitle:@"Error!" withMsg:@"Error occur when setup password!" WithDelegate:nil];
                }
                else
                {
                    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"RemovePwd" style:UIBarButtonItemStylePlain target:self action:@selector(dismissPwd:)] autorelease];
                }
            }
            else
            {
                [UITool showAlertWithTitle:@"Error!" withMsg:@"Password should be equal!" WithDelegate:nil];
            }
        }
    }
    else if([alertTitle isEqualToString:kPassworkdVerify]) 
    {
        if([buttonTitle isEqualToString:kOKButtonTitle])
        {
            NSString* password=nil;
            UIView* subView = [alertView viewWithTag:kInputPwdTag];
            if([subView isKindOfClass:[UITextField class]])
            {
                UITextField* tf = (UITextField*)subView;
                [tf resignFirstResponder];
                password= [tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            if(![password isEqualToString:[DataTool getPassword]])
            {
                [UITool showAlertWithTitle:@"Error!" withMsg:@"Password is wrong!" WithDelegate:nil];
            }
            else
            {
                if([DataTool removePassword])
                {
                    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"SetPwd" style:UIBarButtonItemStylePlain target:self action:@selector(setDiaryPwd:)] autorelease];
                }
                else
                {
                    [UITool showAlertWithTitle:@"Error!" withMsg:@"Failed to remove password!" WithDelegate:nil];
                }
            }
        }
    }   

    
}

@end
