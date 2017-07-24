


//
//  FileManager.m
//  代码自动生成工具
//
//  Created by MAC on 2017/7/19.
//  Copyright © 2017年 czl. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (instancetype)share{
    
    static FileManager *install = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        install = [FileManager new];
    });
    
    return install;
}


+ (NSString *)isExist:(NSString *)path{

    NSArray *files = [[NSFileManager defaultManager]subpathsAtPath:[FileManager defaultPath]];
    for (NSString *p in files) {
        if ([p hasSuffix:path]) {
            return p;
        }
    }
    
    
    return nil;

}

+ (NSString *)createDict:(NSString *)path{
    
    NSString *pathTrue = [[FileManager defaultPath] stringByAppendingPathComponent:path];
    if(![[NSFileManager defaultManager]fileExistsAtPath:pathTrue]){
        
        [[NSFileManager defaultManager]createDirectoryAtPath:pathTrue withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    return path;
}

+ (NSString *)createFile:(NSString *)path content:(NSString *)content{
    NSMutableString *log = [NSMutableString new];
    
    if ([self isExist:path]) {
        [log appendFormat:@"已存在%@，直接添加内容\n",path];
        [[content dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/%@",[FileManager defaultPath],[self isExist:path]] atomically:YES];
        [log appendFormat:@"内容已添加%@完毕\n",path];
    }else{
       [log appendFormat:@"开始生成%@\n",path];
    [[NSFileManager defaultManager]createFileAtPath:[NSString stringWithFormat:@"%@/%@",[FileManager defaultPath],path] contents:[content dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        [log appendFormat:@"生成%@完成\n",path];
    }
    return log;
}

+ (NSString *)defaultPath{

    return [[NSUserDefaults standardUserDefaults] stringForKey:@"filePath"].length>1?[[NSUserDefaults standardUserDefaults] stringForKey:@"filePath"]:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)fileContentFromFile:(NSString *)fileName{

    NSError *error;
    NSString *tts = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject,fileName] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return nil;
    }
    return tts;
}


@end
