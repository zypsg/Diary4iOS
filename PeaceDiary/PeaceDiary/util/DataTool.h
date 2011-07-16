//
//  DataTool.h
//  PeaceDiary
//
//  Created by peacezhao on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFHFKeychainUtils.h"

@interface DataTool : NSObject {
    
}

+ (BOOL) savePassword:(NSString*)pwd;

+ (NSString*) getPassword;

+ (BOOL) removePassword;
@end
