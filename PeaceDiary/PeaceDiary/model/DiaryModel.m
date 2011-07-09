//
//  DiaryModel.m
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DiaryModel.h"
#import "SqliteDataBase.h"
#import "UITool.h"
#import "DateTool.h"


@implementation DiaryModel
@synthesize firstWrong = _firstWrong,secondWrong= _secondWrong,thirdWrong= _thirdWrong;
@synthesize firstThank = _firstThank,secondThank = _secondThank,thirdThank = _thirdThank;
@synthesize todayTitle= _todayTitle;
@synthesize date = _date;
@synthesize modelVersion;



- (id) initWithFirstThank:(NSString*)firstTh withSecondThank:(NSString*)secondTh withThird:(NSString*)thirdTh withFirstWrong:(NSString*)firstWr withSecondWrong:(NSString*)secondW withThirdWrong:(NSString*)thirdW withTitle:(NSString*)title withDate:(NSTimeInterval)adate
{
    self = [super init];
    if(self)
    {
        self.firstThank = firstTh;
        self.secondThank = secondTh;
        self.thirdThank = thirdTh;
        
        self.firstWrong = firstWr;
        self.secondWrong = secondW;
        self.thirdWrong = thirdW;
        
        self.todayTitle = title;
        
        self.date = adate;
    }
    return self;
}

- (id) initWithFilePath:(NSString*)diaryPath
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

- (BOOL) saveDiary
{
    NSLog(@"%@",self);
    BOOL ret = NO;
    SqliteDataBase* db = [[SqliteDataBase alloc] init];
    ret = [db initDB];
    if(ret)
    {
        ret = [db insertDiary:self];
        if(!ret)
        {
            [UITool showAlertWithTitle:@"发生异常" withMsg:@"保存日记失败!" WithDelegate:nil];
        }
    }
    else
    {
        [UITool showAlertWithTitle:@"发生异常" withMsg:@"打开sqlite数据库失败!" WithDelegate:nil];
    }
    [db closeDB];
    [db release];
    return ret;
}

- (NSString*) getDateStr
{
    return [DateTool getTimeStringFromValue:self.date];
}

+ (NSArray*)getDiaryModelFromDB
{
    NSArray* retArray = nil;
    SqliteDataBase* db = [[SqliteDataBase alloc] init];
    BOOL ret = [db initDB];
    if(ret)
    {
        retArray = [db getAllDiary];
    }
    [db closeDB];
    [db release];
    return retArray;
}

- (NSString*) description
{
 
    return [NSString stringWithFormat:@"firstThank:%@,secondThank:%@,thirdThank:%@===firstLesswell:%@,secondLesswell:%@,thirdLesswell:%@====#self.date:%f",self.firstThank,self.secondThank,self.thirdThank,self.firstWrong,self.secondWrong,self.thirdWrong,self.date];
}
- (void) dealloc
{
    [_firstWrong release];
    [_secondWrong release];
    [_thirdWrong release];
    
    [_firstThank release];
    [_secondThank release];
    [_thirdThank release];
    
    [_todayTitle release];
    
    
    [super dealloc];
}
@end
