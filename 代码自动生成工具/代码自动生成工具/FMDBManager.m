


//
//  FMDBManager.m
//  代码自动生成工具
//
//  Created by MAC on 2017/7/19.
//  Copyright © 2017年 czl. All rights reserved.
//

#import "FMDBManager.h"
#import "SqliteModel.h"


@interface FMDBManager ()

@property (nonatomic,strong)FMDatabase *dataBase;

@end

@implementation FMDBManager

+ (instancetype)share{

    static FMDBManager *install = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        install = [FMDBManager new];
    });

    return install;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createDataBase];
    }
    return self;
}

- (void)createDataBase{

    [self.dataBase open];
    [self.dataBase executeQuery:@"CREATE TABLE IF NOT EXISTS allRequest"];
    [self.dataBase close];

}

- (NSArray *)query{

    [self.dataBase open];
    NSMutableArray *newArray = [NSMutableArray new];
    FMResultSet *set = [self.dataBase executeQuery:@"select *from allRequest"];
    while ([set next]) {
        SqliteModel *model = [SqliteModel new];
        model.name = [set stringForColumn:@"name"];
        model.mome = [set stringForColumn:@"mome"];
        model.urlPath = [set stringForColumn:@"urlPath"];
        model.param = [set stringForColumn:@"param"];
        model.response = [set stringForColumn:@"response"];
        [newArray addObject:model];
    }
    return newArray;
}

- (FMDatabase *)dataBase{

    if (!_dataBase) {
        // 实例化FMDataBase对象
        

        _dataBase = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/autoCodeDB.db",[FileManager defaultPath]]];
        
    }
    return _dataBase;
}

@end
