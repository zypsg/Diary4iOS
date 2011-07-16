//
//  SqliteDataBase.m
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SqliteDataBase.h"
#import "DateTool.h"

@implementation SqliteDataBase


- (NSString*) getDatabasePath
{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathname = [path objectAtIndex:0];
	return [pathname stringByAppendingPathComponent:@"diary.sqlite3"];
}

 


- (BOOL) initDB
{
    int retCode = ERR_NONE;
    
         if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK)
    {
//        NSLog(@"Can now use sqlite on multiple threads, using the same connection");
    }
    if (sqlite3_open([[self getDatabasePath] UTF8String],&_sqliteHandle) != SQLITE_OK) {
        sqlite3_close(_sqliteHandle);
        
        retCode = ERR_OPEN;
    }
    else
    {
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS DIARY(ID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,FIRSTLESSWELL NVARCHAR(250),SECONDLESSWELL NVARCHAR(250),THIRDLESSWELL NVARCHAR(250),FIRSTTHANK NVARCHAR(250),SECONDTHANK NVARCHAR(250),THIRDTHANK NVARCHAR(250),SUBJECT NVARCHAR(250),time DOUBLE)";
        if (sqlite3_exec(_sqliteHandle, [createSQL UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
            retCode = ERR_CREATE_TABLE;
        }
    }
    
    return retCode == ERR_NONE;
}

- (BOOL) insertDiary:(DiaryModel*)diary
{
    
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO DIARY(FIRSTLESSWELL,SECONDLESSWELL,THIRDLESSWELL,FIRSTTHANK,SECONDTHANK,THIRDTHANK,SUBJECT,time) VALUES('%@','%@','%@','%@','%@','%@','%@',%f)", 
                     diary.firstWrong,
                     diary.secondWrong,
                     diary.thirdWrong,
                     diary.firstThank,
                     diary.secondThank,
                     diary.thirdThank,
                     diary.todayTitle,
                     diary.date];
//    NSLog(@"sql:%@",sql);
    int retCode = sqlite3_exec(_sqliteHandle, [sql UTF8String], NULL, NULL, &_errMsg);
//    NSLog(@"retCode:%d",retCode);
    return retCode == SQLITE_OK;
}

- (NSArray*)getAllDiary
{
    NSMutableArray* ret = [[NSMutableArray alloc] initWithCapacity:0];
    NSString* sql =  @"select * from DIARY";
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_sqliteHandle, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSString* firstlesswell = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,1)];
            NSString* secondlesswell = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,2)];
            NSString* thirdlesswell = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,3)];
            NSString* firstThank = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,4)];
            NSString* secondThank = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,5)];
            NSString* thirdThank = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,6)];
            NSString* subject = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,7)];
            NSTimeInterval time =  sqlite3_column_double(statement,8);
            
            DiaryModel* diary = [[DiaryModel alloc] initWithFirstThank:firstThank withSecondThank:secondThank withThird:thirdThank withFirstWrong:firstlesswell withSecondWrong:secondlesswell withThirdWrong:thirdlesswell withTitle:subject withDate:time];
            [ret addObject:diary];
            [diary release];

        }
    }
    return ret;
}

- (DiaryModel*) getTodayDiary
{
    DiaryModel* ret = nil;
    NSString* sql = [NSString stringWithFormat:@"select * from DIARY where time between %f and %f ",[DateTool timeIntervalStartOfToDay],kSecondInDay+[DateTool timeIntervalStartOfToDay]];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_sqliteHandle, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSString* firstlesswell = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,1)];
            NSString* secondlesswell = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,2)];
            NSString* thirdlesswell = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,3)];
            NSString* firstThank = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,4)];
            NSString* secondThank = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,5)];
            NSString* thirdThank = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,6)];
            NSString* subject = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,7)];
            NSTimeInterval time =  sqlite3_column_double(statement,8);
            
            ret = [[DiaryModel alloc] initWithFirstThank:firstThank withSecondThank:secondThank withThird:thirdThank withFirstWrong:firstlesswell withSecondWrong:secondlesswell withThirdWrong:thirdlesswell withTitle:subject withDate:time];
            [ret autorelease];
            
        }
    }
    return ret;
}

- (void) closeDB
{
    if (_sqliteHandle)
    {
        sqlite3_close(_sqliteHandle);
        _sqliteHandle = nil;
    }
    
 
}


@end
