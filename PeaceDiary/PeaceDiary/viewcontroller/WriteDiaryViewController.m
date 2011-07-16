//
//  WriteDiaryViewController.m
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "WriteDiaryViewController.h"
#import "UITool.h"



@implementation WriteDiaryViewController
@synthesize firstThankField,secondThankField,thirdThankField;
@synthesize firstWrongField,secondWrongField,thirdWrongField;
@synthesize subjectField;
 
- (id) init
{
    self = [super init];
    if(self)
    {
       
    }
    return self;
}


- (void)dealloc
{
    [firstThankField release];
    [secondThankField release];
    [thirdThankField release];
    
    [firstWrongField release];
    [secondWrongField release];
    [thirdWrongField release];
    
    [subjectField release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/**/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Write Diary";
    self.navigationItem.rightBarButtonItem =  [[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveDiary:)] autorelease];

    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification
     object:nil];
    
    DiaryModel* diary = [DiaryModel getTodayDiary];
    if(diary)
    {
        firstThankField.text = diary.firstThank;
        secondThankField.text = diary.secondThank;
        thirdThankField.text = diary.thirdThank;
        
        firstWrongField.text = diary.firstWrong;
        secondWrongField.text = diary.secondWrong;
        thirdWrongField.text = diary.thirdWrong;
        
        subjectField.text = diary.todayTitle;
    }

    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) saveDiary:(id)sender
{
    NSString* firstLesswell = [firstWrongField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([firstLesswell length]<=0)
    {
        [UITool showAlertWithTitle:@"警告" withMsg:@"请输入Lesswell1" WithDelegate:nil];
        return;
    }
    NSString* secondLessWell = [secondWrongField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([secondLessWell length]<=0)
    {
        [UITool showAlertWithTitle:@"警告" withMsg:@"请输入Lesswell2" WithDelegate:nil];
        return;
    }
    NSString* thirdLessWell = [thirdWrongField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([thirdLessWell length]<=0)
    {
        [UITool showAlertWithTitle:@"警告" withMsg:@"请输入Lesswell3" WithDelegate:nil];
        return;
    }
    
    
    NSString* firstThanks = [firstThankField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([firstThanks length]<=0)
    {
        [UITool showAlertWithTitle:@"警告" withMsg:@"请输入Thanks1" WithDelegate:nil];
        return;
    }
    NSString* secondThanks = [secondThankField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([secondThanks length]<=0)
    {
        [UITool showAlertWithTitle:@"警告" withMsg:@"请输入Thanks2" WithDelegate:nil];
        return;
    }
    NSString* thirdThanks = [thirdThankField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([thirdThanks length]<=0)
    {
        [UITool showAlertWithTitle:@"警告" withMsg:@"请输入Thanks3" WithDelegate:nil];
        return;
    }
    
    
    NSString*subject = [subjectField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([thirdThanks length]<=0)
    {
        [UITool showAlertWithTitle:@"警告" withMsg:@"请输入Thanks3" WithDelegate:nil];
        return;
    }
    
    
    DiaryModel* diary = [[DiaryModel alloc] initWithFirstThank:firstThanks withSecondThank:secondThanks withThird:thirdThanks withFirstWrong:firstLesswell withSecondWrong:secondLessWell withThirdWrong:thirdLessWell withTitle:subject withDate:[[NSDate date] timeIntervalSince1970]];
    BOOL ret  =[diary saveDiary];
    if(ret)
    {
        firstThankField.userInteractionEnabled = NO;
        secondThankField.userInteractionEnabled = NO;
        thirdThankField.userInteractionEnabled = NO;
        
        firstWrongField.userInteractionEnabled  = NO;
        secondWrongField.userInteractionEnabled = NO;
        thirdWrongField.userInteractionEnabled = NO;
        
        subjectField.userInteractionEnabled = NO;
    }
    [diary release];
}

#pragma mark-
#pragma mark--- keyboard releated methods---

- (void) keyboardWillShow:(NSNotification*)note
{    
    NSDictionary* info = [note userInfo];
    
    // Get the frame of the keyboard.
 
    NSValue *boundsValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
 
    CGRect keyboardBounds = [boundsValue CGRectValue]; 
    CGFloat height = keyboardBounds.size.height;
    
    NSNumber* duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    UIViewAnimationCurve  curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:curve];
    UIScrollView* sv = (UIScrollView*)self.view;
    sv.contentSize = CGSizeMake(320, 300);
    sv.scrollEnabled = YES;
    sv.frame = CGRectMake(0, 0, 320, 416-height);
    if([thirdThankField isFirstResponder])
    {
        [sv scrollRectToVisible:thirdThankField.frame animated:YES];
    }
    else if([subjectField isFirstResponder])
    {
        [sv scrollRectToVisible:subjectField.frame animated:YES];
    }
//    [scrollView scrollRectToVisible:textFieldRect animated:YES];
    [UIView commitAnimations];
    
}

- (void) keyboardWillHide:(NSNotification*)note
{
    NSDictionary* info = [note userInfo];
    NSNumber* duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    UIViewAnimationCurve  curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:curve];
    UIScrollView* sv = (UIScrollView*)self.view;
    sv.frame = CGRectMake(0, 0, 320, 416);
    //    [scrollView scrollRectToVisible:textFieldRect animated:YES];
    [UIView commitAnimations];
 
}


#pragma mark-
#pragma mark ---UITextField Delegate Methods ---

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
