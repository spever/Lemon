//
//  BaseModel.h
//  Lemon
//
//  Created by luo on 2023/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ModelProtocol <NSObject>

@optional
-(instancetype)initValueWithDictionary:(NSDictionary *)dic;
-(void)initValue:(id)value forUndefinedKey:(NSString *)key;

@end

@interface BaseModel : NSObject<ModelProtocol>


@end

NS_ASSUME_NONNULL_END
