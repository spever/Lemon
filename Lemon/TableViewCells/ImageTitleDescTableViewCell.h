//
//  ImageTitleDescTableViewCell.h
//  Lemon
//
//  Created by luo on 2023/7/13.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface ImageTitleDescTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *desc;
@property(nonatomic,strong) UIImageView *imageViewBig;

@property(nonatomic,strong) MenuItem *item;

@end

NS_ASSUME_NONNULL_END
