//
//  FileManager.h
//  代码自动生成工具
//
//  Created by MAC on 2017/7/19.
//  Copyright © 2017年 czl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (instancetype)share;

+ (NSString *)isExist:(NSString *)path;

+ (NSString *)createDict:(NSString *)path;

+ (NSString *)createFile:(NSString *)path content:(NSString *)content;

+ (NSString *)fileContentFromFile:(NSString *)fileName;

+ (NSString *)defaultPath;

@end
