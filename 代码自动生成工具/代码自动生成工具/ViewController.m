//
//  ViewController.m
//  代码自动生成工具
//
//  Created by MAC on 2017/7/19.
//  Copyright © 2017年 czl. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"
#import "FileManager.h"
#import "SqliteModel.h"
#import "WHC_XMLParser.h"


#define kWHC_DEFAULT_CLASS_NAME @("WHC")
#define kWHC_CLASS       @("\n\n@interface %@ :NSObject\n\n%@\n@end\n")



#define kWHC_PROPERTY(s)    ((s) == 'c' ? @("\n@property (nonatomic , copy) %@              * %@;\n") : @("\n@property (nonatomic , strong) %@              * %@;\n"))

#define kWHC_PROPERTY_ASSIGN    @("\n@property (nonatomic , assign) %@              %@;\n")

#define kWHC_CLASS_M     @("\n\n@implementation %@\n\n@end\n")

#define kWHC_IMPORT_H    @("\n#import \"%@.h\"\n")

#define kSWHC_CLASS @("\n@objc(%@)\nclass %@ :NSObject{\n%@\n}")
#define kSWHC_PROPERTY @("var %@: %@!;\n")



#define kWHC_CLASS_Prefix_M     @("@implementation %@\n+ (NSString *)prefix {\n    return @\"%@\";\n}\n\n@end\n\n")

#define kWHC_ASSIGN_PROPERTY    @("\n@property (nonatomic , assign) %@              %@;\n")


@implementation ViewController
{
    
    NSMutableString *text;
    
    NSMutableString       *   _classString;        //存类头文件内容
    NSMutableString       *   _classMString;       //存类源文件内容
    BOOL                      _firstLower;         //首字母小写
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"$(SRCROOT");
    text = [NSMutableString new];
    _classString = [NSMutableString new];
    _classMString = [NSMutableString new];
    _firstLower = YES;
    // Do any additional setup after loading the view.
}

- (IBAction)start:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setObject:_filePath.stringValue   forKey:@"filePath"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.textView.string = [NSString stringWithFormat:@"%@/autoCodeDB.db\n",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    
    NSArray *array = [[FMDBManager share]query];
    
    for (SqliteModel *model in array) {
  
       NSString *dict = [FileManager createDict:model.name];
        
       [self addText:[FileManager createFile:[NSString stringWithFormat:@"%@/%@Api.h",dict,[self upper:model.name]] content:[self stringApiH:model]]];
     
        
       
       [self addText: [FileManager createFile:[NSString stringWithFormat:@"%@/%@Api.m",dict,[self upper:model.name]] content:[self stringApiM:model]]];
       
        [self addText:[FileManager createFile:[NSString stringWithFormat:@"%@/%@ApiAction.h",dict,[self upper:model.name]] content:[self stringApiActionH:model]]];
        
        [self addText:[FileManager createFile:[NSString stringWithFormat:@"%@/%@ApiAction.m",dict,[self upper:model.name]] content:[self stringApiActionM:model]]];
        
        
        [self stringApiModel:model];
        
    }
    
    
}

- (void)addText:(NSString *)texts{
    
    [text appendString:[NSString stringWithFormat:@"%@\n",texts]];
    self.textView.string = text;
    
    
}


- (NSString *)stringApiActionH:(SqliteModel *)model{
    
    NSString *desc = [FileManager fileContentFromFile:@"testApiAction.h"];
    //    [desc stringByReplacingOccurrencesOfString:@"?" withString:model.name];
    
    NSArray *params = [model.param componentsSeparatedByString:@","];
    NSMutableString *param = [NSMutableString new];
    for (int i =0 ;i<params.count;i++) {
        NSString *str = params[i];
        if (i==0) {
            [param appendFormat:@"With%@:(NSString *)%@",[self upper:str],str];
        }else{
            [param appendFormat:@" %@:(NSString *)%@",str,str];
        }
    }
    
    return [NSString stringWithFormat:desc,[self upper:model.name],model.mome,[self date],[self upper:model.name],model.name,param];
    
}


- (NSString *)stringApiActionM:(SqliteModel *)model{
    
    NSString *desc = [FileManager fileContentFromFile:@"testApiAction.m"];
    //    [desc stringByReplacingOccurrencesOfString:@"?" withString:model.name];
    
    NSArray *params = [model.param componentsSeparatedByString:@","];
    NSMutableString *property = [NSMutableString new];
    NSMutableString *param = [NSMutableString new];

    for (int i =0 ;i<params.count;i++) {
        NSString *str = params[i];
        if (i==0) {
            [param appendFormat:@"With%@:(NSString *)%@",[self upper:str],str];
            [property appendFormat:@"With%@:%@",[self upper:str],str];
        }else{
            [param appendFormat:@" %@:(NSString *)%@",str,str];
            [property appendFormat:@" %@:%@",str,str];
        }
        

    }
    
    return [NSString stringWithFormat:desc,[self upper:model.name],model.mome,[self date],[self upper:model.name],[self upper:model.name],[self upper:model.name],model.name,param,[self upper:model.name],[self upper:model.name],property];
    
}

- (NSString *)stringApiH:(SqliteModel *)model{
    
    NSString *desc = [FileManager fileContentFromFile:@"testApi.h"];
    //    [desc stringByReplacingOccurrencesOfString:@"?" withString:model.name];
    
    NSArray *params = [model.param componentsSeparatedByString:@","];
    NSMutableString *param = [NSMutableString new];
    for (int i =0 ;i<params.count;i++) {
        NSString *str = params[i];
        if (i==0) {
            [param appendFormat:@"With%@:(NSString *)%@",[self upper:str],str];
        }else{
            [param appendFormat:@" %@:(NSString *)%@",str,str];
        }
    }
    
    return [NSString stringWithFormat:desc,[self upper:model.name],model.mome,[self date],[self upper:model.name],param];
    
}

- (NSString *)stringApiM:(SqliteModel *)model{
    
    NSString *desc = [FileManager fileContentFromFile:@"testApi.m"];
    //    [desc stringByReplacingOccurrencesOfString:@"?" withString:model.name];
    
    NSArray *params = [model.param componentsSeparatedByString:@","];
    NSMutableString *property = [NSMutableString new];
    NSMutableString *param = [NSMutableString new];
    NSMutableString *keyValue = [NSMutableString new];
    NSMutableString *redic = [[NSMutableString alloc]initWithString:@"@{"];
    NSString *redics;
    for (int i =0 ;i<params.count;i++) {
        NSString *str = params[i];
        if (i==0) {
            [param appendFormat:@"With%@:(NSString *)%@",[self upper:str],str];
        }else{
            [param appendFormat:@" %@:(NSString *)%@",str,str];
        }
        [property appendFormat:@"NSString *_%@;\n",str];
        [keyValue appendFormat:@"_%@ = %@;\n",str,str];
        [redic appendFormat:@"@\"%@\":_%@,",str,str];
        if (i == params.count-1) {
            redics = [[redic substringToIndex:redic.length-1] stringByAppendingString:@"}\n"];
        }
    }
    
    return [NSString stringWithFormat:desc,[self upper:model.name],model.mome,[self date],[self upper:model.name],[self upper:model.name],property,param,keyValue,model.urlPath,redics];
    
}


- (void)stringApiModel:(SqliteModel *)model{
    
    [_classString deleteCharactersInRange:NSMakeRange(0, _classString.length)];
    [_classMString deleteCharactersInRange:NSMakeRange(0, _classMString.length)];
    NSString  * className = [[self upper:model.name] stringByAppendingString:@"Model"];
    NSString  * json = model.response;
    if(className == nil){
        className = kWHC_DEFAULT_CLASS_NAME;
    }
    if(className.length == 0){
        className = kWHC_DEFAULT_CLASS_NAME;
    }
    if(json && json.length){
        NSDictionary  * dict = nil;
        if([json hasPrefix:@"<"]){
            //xml
            dict = [WHC_XMLParser dictionaryForXMLString:json];
        }else{
            //json
            NSData  * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:NULL];
        }
        
        [_classMString appendFormat:kWHC_CLASS_M,className];
        
        NSString *content = [self handleDataEngine:dict key:nil path:model.name];
         NSRange range = [content rangeOfString:@"@property"];
        [_classString appendFormat:kWHC_CLASS,className,[content substringFromIndex:range.location]];
        
       
        
       [self addText:[FileManager createFile:[NSString stringWithFormat:@"%@/%@.h",model.name,className] content:[NSString stringWithFormat:@"%@\n\n%@",[content substringToIndex:range.location],_classString]]];
        
        
        [self addText:[FileManager createFile:[NSString stringWithFormat:@"%@/%@.m",model.name,className] content:_classMString]];
        
        
    }
    
    
}




#pragma mark -解析处理引擎-

- (NSString*)handleDataEngine:(id)object key:(NSString*)key path:(NSString *)path{
//    NSString * _classPrefixName = _classBefore.stringValue;
    if(object){
        
        NSMutableString  * property = [NSMutableString new];
        
        if([object isKindOfClass:[NSDictionary class]]){
            NSDictionary  * dict = object;

            [dict enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull subObject, BOOL * _Nonnull stop) {
                NSString *className = [[self upper:key] stringByAppendingString:@"Model"];
//                NSString * className = [self handleAfterClassName:key];
                NSString * propertyName = [self handlePropertyName:key];
                if([subObject isKindOfClass:[NSDictionary class]]){
                    NSString * classContent = [self handleDataEngine:subObject key:key path:path];
                  
                    [property appendFormat:kWHC_PROPERTY('s'),className,propertyName];
                    
                    
                    [property insertString:[NSString stringWithFormat:kWHC_IMPORT_H,className] atIndex:0];
                    
                    NSRange range = [classContent rangeOfString:@"@property"];
                    
                    [self addText:[FileManager createFile:[NSString stringWithFormat:@"%@/%@.h",path,className] content:[NSString stringWithFormat:@"%@\n\n%@",[classContent substringToIndex:range.location],[NSString stringWithFormat:kWHC_CLASS,className,[classContent substringFromIndex:range.location]]]]];
                    
                    [self addText:[FileManager createFile:[NSString stringWithFormat:@"%@/%@.m",path,className] content:[NSString stringWithFormat:kWHC_CLASS_M,className]]];
                    
                    
                }else if ([subObject isKindOfClass:[NSArray class]]){
                    id firstValue = nil;
                    NSString * classContent = nil;
                    if (((NSArray *)subObject).count > 0) {
                        firstValue = ((NSArray *)subObject).firstObject;
                    }else {
                        goto ARRAY_PASER;
                    }
                    if ([firstValue isKindOfClass:[NSString class]] ||
                        [firstValue isKindOfClass:[NSNumber class]]) {
                        if ([firstValue isKindOfClass:[NSString class]]) {
                            
                                [property appendFormat:kWHC_PROPERTY('s'),[NSString stringWithFormat:@"NSArray<%@ *>",@"NSString"],key];
                            
                        }else {
                            
                                [property appendFormat:kWHC_PROPERTY('s'),[NSString stringWithFormat:@"NSArray<%@ *>",@"NSNumber"],key];
                            
                        }
                    }else {
                    ARRAY_PASER:
                        classContent = [self handleDataEngine:subObject key:key path:path];
                        
                            [property appendFormat:kWHC_PROPERTY('s'),[NSString stringWithFormat:@"NSArray<%@ *>",className],propertyName];
                        
                        NSRange range = [classContent rangeOfString:@"@property"];
                        
                        [self addText:[FileManager createFile:[NSString stringWithFormat:@"%@/%@.h",path,className] content:[NSString stringWithFormat:@"%@\n\n%@",[classContent substringToIndex:range.location],[NSString stringWithFormat:kWHC_CLASS,className,[classContent substringFromIndex:range.location]]]]];
                        
                        [self addText:[FileManager createFile:[NSString stringWithFormat:@"%@/%@.m",path,className] content:[NSString stringWithFormat:kWHC_CLASS_M,className]]];
                        
                    }
                }else if ([subObject isKindOfClass:[NSString class]]){
                    
                        [property appendFormat:kWHC_PROPERTY('c'),@"NSString",propertyName];
                    
                }else if ([subObject isKindOfClass:[NSNumber class]]){
                    
                        if (strcmp([subObject objCType], @encode(float)) == 0 ||
                            strcmp([subObject objCType], @encode(CGFloat)) == 0) {
                            [property appendFormat:kWHC_ASSIGN_PROPERTY,@"CGFloat",propertyName];
                        }else if (strcmp([subObject objCType], @encode(double)) == 0) {
                            [property appendFormat:kWHC_ASSIGN_PROPERTY,@"CGFloat",propertyName];
                        }else if (strcmp([subObject objCType], @encode(BOOL)) == 0) {
                            [property appendFormat:kWHC_ASSIGN_PROPERTY,@"BOOL",propertyName];
                        }else {
                            [property appendFormat:kWHC_ASSIGN_PROPERTY,@"NSInteger",propertyName];
                        }
                    
                }else{
                    if(subObject == nil){
                       
                            [property appendFormat:kWHC_PROPERTY('c'),@"NSString",propertyName];
                        
                    }else if([subObject isKindOfClass:[NSNull class]]){
                        
                            [property appendFormat:kWHC_PROPERTY('c'),@"NSString",propertyName];
                        
                    }
                }
            }];
        }else if ([object isKindOfClass:[NSArray class]]){
            NSArray  * dictArr = object;
            NSUInteger  count = dictArr.count;
            if(count){
                NSObject  * tempObject = dictArr[0];
                for (NSInteger i = 0; i < dictArr.count; i++) {
                    NSObject * subObject = dictArr[i];
                    if([subObject isKindOfClass:[NSDictionary class]]){
                        if(((NSDictionary *)subObject).count > ((NSDictionary *)tempObject).count){
                            tempObject = subObject;
                        }
                    }
                    if([subObject isKindOfClass:[NSDictionary class]]){
                        if(((NSArray *)subObject).count > ((NSArray *)tempObject).count){
                            tempObject = subObject;
                        }
                    }
                }
                [property appendString:[self handleDataEngine:tempObject key:key path:path]];
            }
        }else{
            NSLog(@"key = %@",key);
        }

        return property;
    }
    return @"";
}

- (NSString *)handleAfterClassName:(NSString *)className {
    if (className != nil && className.length > 0) {
        NSString * first = [className substringToIndex:1];
        NSString * other = [className substringFromIndex:1];
        return [NSString stringWithFormat:@"%@%@%@",_classBefore.stringValue,[first uppercaseString],other];
    }
    return className;
}

- (NSString *)handlePropertyName:(NSString *)propertyName {
    if (_firstLower) {
        if (propertyName != nil && propertyName.length > 0) {
            NSString * first = [propertyName substringToIndex:1];
            NSString * other = [propertyName substringFromIndex:1];
            return [NSString stringWithFormat:@"%@%@",[first lowercaseString],other];
        }
    }
    return propertyName;
}

- (NSString *)upper:(NSString *)str{
    
    return [_classBefore.stringValue stringByAppendingString:[[[str substringToIndex:1] uppercaseString] stringByAppendingString:[str substringFromIndex:1]]];
    
}

- (IBAction)clear:(id)sender {
    text = @"".mutableCopy;
    self.textView.string = text;
}

- (NSString *)date{

    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"YYYY/MM/dd";
    format.timeZone = [NSTimeZone systemTimeZone];
    return [format stringFromDate:[NSDate date]];
}

@end
