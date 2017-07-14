//
//  WCDemoORM.h
//  TabDemo
//
//  Created by EEKA on 2017/7/13.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

@interface WCDemoORM : NSObject <WCTTableCoding>

@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *timestamp;

WCDB_PROPERTY(code)
WCDB_PROPERTY(token)
WCDB_PROPERTY(name)
WCDB_PROPERTY(timestamp)

@end
