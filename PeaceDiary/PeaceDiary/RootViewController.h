//
//  RootViewController.h
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UITextFieldDelegate>{

}


- (void) setDiaryPwd:(id)sender;

- (void) dismissPwd:(id)sender;

- (void) showRequirePwdView;

- (void) showAlertWithTextFieldWithTitle:(NSString*)title;
@end
