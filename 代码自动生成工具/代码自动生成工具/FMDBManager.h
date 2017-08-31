//
//  FMDBManager.h
//  代码自动生成工具
//
//  Created by MAC on 2017/7/19.
//  Copyright © 2017年 czl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "FileManager.h"

@interface FMDBManager : NSObject

+ (instancetype)share;

- (NSArray *)query;


@end
