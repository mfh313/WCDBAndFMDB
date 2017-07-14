//
//  FMDBTestViewController.m
//  TabDemo
//
//  Created by EEKA on 2017/6/30.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "FMDBTestViewController.h"
#import "Macro.h"
#import <FMDB/FMDB.h>
#import <objc/runtime.h>
#import <objc/message.h>


@implementation DBdata

+(instancetype)objectWithTitle:(NSString *)title
                     target:(id)target
                   action:(SEL)action
{
    DBdata *object = [DBdata new];
    
    object.title = title;
    object.target = target;
    object.action = action;
    
    return object;
}


@end

#pragma mark - FMDBTestViewController
@interface FMDBTestViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_dbPath;
    FMDatabase *_db;
    UITableView *_tableView;
    NSMutableArray *_dbArray;
}

@end

@implementation FMDBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FMDB";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dbPath = [MFDocumentDirectory stringByAppendingPathComponent:@"mafanghua"];
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    [fileManager removeItemAtPath:_dbPath error:nil];
    
    _db =[FMDatabase databaseWithPath:_dbPath];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 52.0;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_tableView];
    
    DBdata *tableCreate = [DBdata objectWithTitle:@"创建表格" target:self action:@selector(onCreateTable)];
    DBdata *tableAlter = [DBdata objectWithTitle:@"表格增加字段" target:self action:@selector(onClickAlterTable)];
    DBdata *tableInsert = [DBdata objectWithTitle:@"插入数据" target:self action:@selector(onClickInsertData)];
    DBdata *tableQuery = [DBdata objectWithTitle:@"查询数据" target:self action:@selector(onClickQuery)];
    DBdata *tableUpdate = [DBdata objectWithTitle:@"更新数据" target:self action:@selector(onClickUpdate)];
    DBdata *tableDelete = [DBdata objectWithTitle:@"删除数据" target:self action:@selector(onClickDelete)];
    DBdata *tableTrancation = [DBdata objectWithTitle:@"事务" target:self action:@selector(onClickTrancation)];
    
    
    
    _dbArray = [NSMutableArray array];
    [_dbArray addObject:tableCreate];
    [_dbArray addObject:tableAlter];
    [_dbArray addObject:tableInsert];
    [_dbArray addObject:tableQuery];
    [_dbArray addObject:tableUpdate];
    [_dbArray addObject:tableDelete];
    [_dbArray addObject:tableTrancation];
    
}


- (void)onCreateTable
{
    if ([_db open]) {
        NSString *sql = @"CREATE TABLE 'mafanghua' ('id' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT,'near' TEXT,'nearest' TEXT)";
        if ([_db executeUpdate:sql]) {
            NSLog(@"新建表成功");
            
            [_db close];
        }
        else
        {
            NSLog(@"新建表失败");
        }
    }
}

- (void)onClickAlterTable
{
    if ([_db open]) {
        NSString *sql = @"ALTER TABLE mafanghua ADD COLUMN sex char(1)";
        if ([_db executeUpdate:sql]) {
            NSLog(@"ALTER成功");
            
            [_db close];
        }
        else
        {
            NSLog(@"ALTER失败");
        }
    }
}

- (void)onClickInsertData
{
    if ([_db open]) {
        static int idx = 1;
        NSString *inSertSql = @"INSERT INTO mafanghua (name,near,nearest) VALUES (?,?,?)";
        NSString *name = [NSString stringWithFormat:@"mafanghua%d",idx++];
        if ([_db executeUpdate:inSertSql,name,@"xxx",@"sdadsad"]) {
            NSLog(@"插入成功");
            
            [_db close];
        }
        else
        {
            NSLog(@"插入失败");
        }
    }
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
