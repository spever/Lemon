//
//  ZhihuNewsItem.h
//  Lemon
//
//  Created by luo on 2023/7/14.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhihuNewsItem : BaseModel

@property(nonatomic,copy) NSString *image_hue;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *hint;
@property(nonatomic,copy) NSString *ga_prefix;
@property(nonatomic,copy) NSArray *images;
@property(nonatomic,assign) int type;
@property(nonatomic,assign) int id;

@end

NS_ASSUME_NONNULL_END
