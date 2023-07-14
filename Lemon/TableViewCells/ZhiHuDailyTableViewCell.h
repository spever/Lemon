//
//  ZhiHuDailyTableViewCell.h
//  Lemon
//
//  Created by luo on 2023/7/14.
//

#import <UIKit/UIKit.h>
#import "ZhihuNewsItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhiHuDailyTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *hint;
@property(nonatomic,strong) UIImageView *iv;

@property(nonatomic,strong) ZhihuNewsItem *item;

@end

NS_ASSUME_NONNULL_END
