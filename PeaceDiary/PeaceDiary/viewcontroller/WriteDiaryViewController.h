//
//  WriteDiaryViewController.h
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WriteDiaryViewController : UIViewController <UITextFieldDelegate>{
    UITextField* firstThankField;
    UITextField* secondThankField;
    UITextField* thirdThankField;
    
    UITextField* firstWrongField;
    UITextField* secondWrongField;
    UITextField* thirdWrongField;
    
    UITextField* subjectField;
}

@property (nonatomic, retain) IBOutlet UITextField* firstThankField;
@property (nonatomic, retain) IBOutlet UITextField* secondThankField;
@property (nonatomic, retain) IBOutlet UITextField* thirdThankField;

@property (nonatomic, retain) IBOutlet UITextField* firstWrongField;
@property (nonatomic, retain) IBOutlet UITextField* secondWrongField;
@property (nonatomic, retain) IBOutlet UITextField* thirdWrongField;

@property (nonatomic, retain) IBOutlet UITextField* subjectField;


- (IBAction) saveDiary:(id)sender;

- (void) keyboardWillShow:(NSNotification*)note;

- (void) keyboardWillHide:(NSNotification*)note;

@end
