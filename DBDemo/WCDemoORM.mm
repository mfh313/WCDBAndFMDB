//
//  WCDemoORM.m
//  TabDemo
//
//  Created by EEKA on 2017/7/13.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "WCDemoORM.h"

@implementation WCDemoORM

WCDB_IMPLEMENTATION(WCDemoORM)

WCDB_SYNTHESIZE(WCDemoORM, code)
WCDB_SYNTHESIZE_COLUMN(WCDemoORM, token, "loginToken") //use "loginToken" as column name in Database
WCDB_SYNTHESIZE(WCDemoORM, name)
WCDB_SYNTHESIZE_DEFAULT(WCDemoORM, timestamp, WCTDefaultTypeCurrentTimestamp)

//WCDB_PRIMARY(WCDemoORM, code)

@end
