//
//  DateTool.m
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DateTool.h"


@implementation DateTool

+ (NSTimeInterval) getTimeValueFromString:(NSString*) timeVal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:timeVal];
    [dateFormatter release];
    NSTimeInterval timeFrom1970 = [date timeIntervalSince1970];
    
    return timeFrom1970;
}

+ (NSString*) getTimeStringFromValue:(int) timeVal
{
    NSString* timeString = nil;
    NSDate* date = (NSDate*) [NSDate dateWithTimeIntervalSince1970:timeVal];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    timeString = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    NSLog(@"timeVal:%d,timeString:%@",timeVal,timeString);
    return timeString;
}

@end
