//
//  SqliteDataBase.h
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DiaryModel.h"

enum
{
    ERR_NONE,
    ERR_OPEN,
    ERR_CREATE_TABLE
};

@interface SqliteDataBase : NSObject {
    sqlite3* _sqliteHandle;
    char* _errMsg;
}

- (BOOL) initDB;
- (void) closeDB;

- (BOOL) insertDiary:(DiaryModel*)diary;

- (NSArray*)getAllDiary;

- (DiaryModel*) getTodayDiary;

- (BOOL) updateTodayDiary:(DiaryModel*)diary;

@end
