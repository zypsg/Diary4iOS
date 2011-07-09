//
//  DiaryListViewController.h
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DiaryListViewController : UITableViewController {
    NSArray* diaryArray;
}
@property (nonatomic, retain) NSArray* diaryArray;

- (id) initWithDiaryArray:(NSArray*)array;
@end
