//
//  WCDBTestViewController.m
//  TabDemo
//
//  Created by EEKA on 2017/7/14.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "WCDBTestViewController.h"
#import "WCDemoORM.h"
#import "Macro.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface WCDBTestViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_dbPath;
    UITableView *_tableView;
    NSMutableArray *_dbArray;
}

@end

@implementation WCDBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WCDB";
    self.view.backgroundColor = [UIColor whiteColor];
    
    Class cls = WCDemoORM.class;
    NSString *fileName = NSStringFromClass(cls);
    
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 52.0;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_tableView];
    
    DBdata *testORM = [DBdata objectWithTitle:@"创建表格" target:self action:@selector(testORM)];
    DBdata *tableInsert = [DBdata objectWithTitle:@"插入数据" target:self action:@selector(onClickInsertData)];
    
    _dbArray = [NSMutableArray array];
    [_dbArray addObject:testORM];
    [_dbArray addObject:tableInsert];

}

-(void)testORM
{
    Class cls = WCDemoORM.class;
    NSString *fileName = NSStringFromClass(cls);
    NSString *tableName = NSStringFromClass(cls);
    
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:fileName];
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    [database close:^{
        [database removeFilesWithError:nil];
    }];
    
    BOOL ret = [database createTableAndIndexesOfName:tableName withClass:cls];
    assert(ret);
    
    NSArray *schemas = [database getAllObjectsOnResults:{WCTMaster.name, WCTMaster.sql} fromTable:WCTMaster.TableName];
    for (WCTMaster *table : schemas) {
        NSLog(@"SQL Of %@: %@", table.name, table.sql);
    }
}


- (void)onClickAlterTable
{

}

- (void)onClickInsertData
{
    WCDemoORM *object = [WCDemoORM new];
    object.name = @"1222";
    object.code = @"object";
    object.token = @"token";
    
    Class cls = WCDemoORM.class;
    NSString *fileName = NSStringFromClass(cls);
    NSString *tableName = NSStringFromClass(cls);
    
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:fileName];
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    
    [database insertObject:object into:tableName];
}

- (void)onClickQuery
{
    
}

- (void)onClickUpdate
{
    
}

- (void)onClickDelete
{
    
}

- (void)onClickTrancation
{
    
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dbArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dbActionCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dbActionCell"];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    DBdata *data = _dbArray[indexPath.row];
    cell.textLabel.text = data.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DBdata *data = _dbArray[indexPath.row];
    objc_msgSend((id)data.target,(SEL)data.action);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
