//
//  MenuItem.h
//  Lemon
//
//  Created by luo on 2023/6/29.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuItem : BaseModel

@property(nonatomic,assign) int id;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *pic;
@property(nonatomic,strong) NSString *food_str;
@property(nonatomic,assign) int collect_num;
@property(nonatomic,assign) int num;


//+ (MenuItem *)configWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
