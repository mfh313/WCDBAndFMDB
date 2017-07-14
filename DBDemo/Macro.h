//
//  Macro.h
//  TabDemo
//
//  Created by EEKA on 2017/7/13.
//  Copyright © 2017年 eeka. All rights reserved.
//


#define MFDocumentDirectory NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

@interface DBdata : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) id target;
@property (nonatomic,assign) SEL action;

+(instancetype)objectWithTitle:(NSString *)title
                        target:(id)target
                        action:(SEL)action;

@end
