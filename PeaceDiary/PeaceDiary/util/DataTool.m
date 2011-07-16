//
//  DataTool.m
//  PeaceDiary
//
//  Created by peacezhao on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DataTool.h"


@implementation DataTool


+ (BOOL) savePassword:(NSString*)pwd
{                NSError* error = nil;
    NSString* username = @"haspassword";
    return [SFHFKeychainUtils storeUsername:username andPassword:pwd forServiceName:@"diary" updateExisting:YES error:&error];
}

+ (NSString*) getPassword
{
    NSError* error = nil;
    NSString* username = @"haspassword";
    
    return [SFHFKeychainUtils  getPasswordForUsername:username andServiceName:@"diary" error:&error];
}

+ (BOOL) removePassword
{
    NSError* error = nil;
    NSString* username = @"haspassword";

    return [SFHFKeychainUtils deleteItemForUsername:username andServiceName:@"diary" error:&error];
}
@end
