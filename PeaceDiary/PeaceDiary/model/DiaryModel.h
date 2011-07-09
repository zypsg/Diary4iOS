//
//  DiaryModel.h
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DiaryModel : NSObject {
    NSString* _firstWrong;
    NSString* _secondWrong;
    NSString* _thirdWrong;
    
    NSString* _firstThank;
    NSString* _secondThank;
    NSString* _thirdThank;
    
    NSString* _todayTitle;
    
    NSTimeInterval _date;  
    CGFloat modelVersion;
}
@property (nonatomic, retain) NSString* firstWrong;
@property (nonatomic, retain) NSString* secondWrong;
@property (nonatomic, retain) NSString* thirdWrong;

@property (nonatomic, retain) NSString* firstThank;
@property (nonatomic, retain) NSString* secondThank;
@property (nonatomic, retain) NSString* thirdThank;

@property (nonatomic, retain) NSString* todayTitle;

@property (nonatomic, assign) NSTimeInterval date; 

@property (nonatomic, assign) CGFloat modelVersion;


- (id) initWithFirstThank:(NSString*)firstTh withSecondThank:(NSString*)secondTh withThird:(NSString*)thirdTh withFirstWrong:(NSString*)firstWr withSecondWrong:(NSString*)secondW withThirdWrong:(NSString*)thirdW withTitle:(NSString*)title withDate:(NSTimeInterval)adate;

- (id) initWithFilePath:(NSString*)diaryPath;

- (BOOL) saveDiary;

- (NSString*) getDateStr;

+ (NSArray*)getDiaryModelFromDB;



@end
