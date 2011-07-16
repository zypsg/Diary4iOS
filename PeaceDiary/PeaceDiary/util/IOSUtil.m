//
//  IOSUtil.m
//  PeaceDiary
//
//  Created by peacezhao on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "IOSUtil.h"


@implementation IOSUtil


//iOS4.0 之前版本
+ (BOOL) isPreIOS4
{
    NSString* version = [UIDevice currentDevice].systemVersion;
    if([version floatValue]<4.0)
    {
        return YES;
    }
    return NO;
}
@end
