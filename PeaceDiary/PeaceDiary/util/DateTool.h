//
//  DateTool.h
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  kSecondInDay 86400

@interface DateTool : NSObject {
    
}

+ (NSTimeInterval) getTimeValueFromString:(NSString*) timeVal;

+ (NSString*) getTimeStringFromValue:(int) timeVal;

+ (NSDate *) dateAtStartOfToDay;

+ (NSTimeInterval) timeIntervalStartOfToDay;
@end
