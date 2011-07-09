//
//  UITool.m
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UITool.h"


@implementation UITool

+(void) showAlertWithTitle:(NSString*)title withMsg:(NSString*) msg WithDelegate:(id)delegate
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg  delegate:delegate cancelButtonTitle:@"确定"  otherButtonTitles: nil];
    [alertView show];
    [alertView release];
}

@end
