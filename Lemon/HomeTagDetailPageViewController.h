//
//  HomeTagDetailPageViewController.h
//  Lemon
//
//  Created by luo on 2023/7/3.
//

#import <UIKit/UIKit.h>
#import "MineViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TransWithData)(NSString *str);

@interface HomeTagDetailPageViewController : UIViewController<MineDelegate>

@property(nonatomic,copy) TransWithData block;

//-(void)receiveData:(TransWithData) transBlock;

@property(nonatomic,copy) NSString *itemData;

@end

NS_ASSUME_NONNULL_END
