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
    return timeString;
}

+ (NSDate *) dateAtStartOfToDay
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit) fromDate:[NSDate date]];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (NSTimeInterval) timeIntervalStartOfToDay
{
    NSTimeInterval time = [[DateTool dateAtStartOfToDay] timeIntervalSince1970];
    return time;
}
@end
