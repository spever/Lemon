//
//  ToastUtils.h
//  Lemon
//
//  Created by luo on 2023/6/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,Gravity) {
    TOP,
    CENTER,
    BOTTOM
};



@interface ToastUtils : NSObject

+(instancetype)toast;

-(void)showToast:(NSString *)msg;

-(void)showToast:(NSString *)msg duration:(NSTimeInterval)duration;

-(void)showToast:(NSString *)msg duration:(NSTimeInterval)duration gravity:(Gravity)gravity;

-(void)showToast:(NSString *)msg duration:(NSTimeInterval)duration gravity:(Gravity)gravity finishHandler:(dispatch_block_t)finishHandler;


@end

NS_ASSUME_NONNULL_END
