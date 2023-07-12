//
//  BaseModel.m
//  Lemon
//
//  Created by luo on 2023/6/29.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initValueWithDictionary:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    if([self respondsToSelector:@selector(initValue:forUndefinedKey:)]){
        [self initValue:value forUndefinedKey:key];
    }
}


@end
