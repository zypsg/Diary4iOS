//
//  DiaryReadViewController.h
//  PeaceDiary
//
//  Created by peacezhao on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryModel.h"

@interface DiaryReadViewController : UITableViewController {
    DiaryModel* diary;
}
@property (nonatomic, retain)  DiaryModel* diary;

- initWithDiary:(DiaryModel*)model;

@end
