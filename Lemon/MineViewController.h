//
//  MineViewController.h
//  Lemon
//
//  Created by luo on 2023/6/21.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewController.h"

NS_ASSUME_NONNULL_BEGIN

//typedef void(^TransData)(NSString *str);

@protocol MineDelegate <NSObject>

-(void)sendValue:(NSString *)value;

@end


@interface MineViewController :BaseTabViewController<UITableViewDataSource,UITableViewDelegate,MineDelegate>
//{
//    
//    NSMutableArray *myData;
//}
//1、delegate 传递数据
@property(nonatomic,assign) id<MineDelegate> mDelegate;


//2、block传递数据
//-(void)transData:(TransData) block;

@end

NS_ASSUME_NONNULL_END
