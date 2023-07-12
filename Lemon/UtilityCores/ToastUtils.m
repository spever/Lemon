//
//  ToastUtils.m
//  Lemon
//
//  Created by luo on 2023/6/30.
//

#import <Foundation/Foundation.h>
#import "ToastUtils.h"


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#define MultilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MultilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize] : CGSizeZero;
#endif

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

const CGFloat toast_padding = 12;

const CGFloat toast_cornerRadius = 4;

const CGFloat toast_fontSize = 12;

const NSTimeInterval ANIM_DURATION = 0.2;

const NSTimeInterval TOAST_DEFAULT_DURATION = 2.5;



@interface ToastUtils ()

@property(nonatomic,strong) UIView *toastView;
@property(nonatomic,strong) NSTimer *toastTimer;
@property(nonatomic,strong) NSTimer *dismissTimer;
@property(nonatomic,copy) dispatch_block_t finishHandler;

@end



@implementation ToastUtils

@synthesize toastView;
@synthesize toastTimer;
@synthesize dismissTimer;
@synthesize finishHandler;

+ (nonnull instancetype)toast {
    static ToastUtils *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ToastUtils alloc] init];
    });
    return instance;
}

- (void)showToast:( NSString *)msg {
    [self toastShow:msg duration:TOAST_DEFAULT_DURATION gravity:BOTTOM finishHandler:^{
            NSLog(@"Toast dismiss: msg: %@",msg);
    }];
}

- (void)showToast:( NSString *)msg duration:(NSTimeInterval)duration {
    [self toastShow:msg duration:duration gravity:BOTTOM finishHandler:^{
            NSLog(@"Toast dismiss: msg: %@",msg);
    }];
}

- (void)showToast:( NSString *)msg duration:(NSTimeInterval)duration gravity:(Gravity)gravity {
    [self toastShow:msg duration:duration gravity:gravity finishHandler:^{
            NSLog(@"Toast dismiss: msg: %@",msg);
    }];
}

- (void)showToast:( NSString *)msg duration:(NSTimeInterval)duration gravity:(Gravity)gravity finishHandler:(nonnull dispatch_block_t)finishHandler {
    [self toastShow:msg duration:duration gravity:gravity finishHandler:finishHandler];
}


- (void)toastShow:( NSString *)msg duration:(NSTimeInterval)duration gravity:(Gravity)gravity finishHandler:(nonnull dispatch_block_t)finishHandler{
    self.finishHandler = finishHandler;
    if(toastView || toastView.superview){
        [self removeToast];
    }
    [self initToastView:msg gravity:gravity];
    if(toastView){
        toastView.alpha=0;
        [[[UIApplication sharedApplication].windows firstObject] addSubview:toastView];
        [[[UIApplication sharedApplication].windows firstObject] bringSubviewToFront:toastView];
    }
    
    [UIView animateWithDuration:ANIM_DURATION animations:^{
            if(self.toastView){
                self.toastView.alpha=1;
            }
    }];
    
    toastTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(finishDismiss) userInfo:nil repeats:NO];
    

}


- (void)initToastView:(NSString *)msg gravity:(Gravity)gravity{
    CGSize toastSize = [self getToastSizeWithMessage:msg];
    CGFloat toastWidth = toastSize.width;
    CGFloat toastHeight = toastSize.height;
    CGFloat x  = (SCREEN_WIDTH - toastWidth)/2;
    CGFloat y = (SCREEN_HEIGHT - toastHeight) *5/6;
    switch (gravity) {
        case TOP:
            y = (SCREEN_HEIGHT -toastHeight) /6;
            break;
        case CENTER:
            y = (SCREEN_HEIGHT -toastHeight) /2;
            break;
        case BOTTOM:
            y = (SCREEN_HEIGHT -toastHeight) *5/6;
            break;
            
        default:
            break;
    }
    toastView = [[UIView alloc] init];
    toastView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    toastView.layer.cornerRadius = toast_cornerRadius;
    toastView.frame = CGRectMake(x, y, toastWidth, toastHeight);
    UILabel *msgLabel = [[UILabel alloc]initWithFrame:toastView.bounds];
    msgLabel.text =msg;
    msgLabel.textColor = [UIColor whiteColor];
    msgLabel.font = [UIFont systemFontOfSize:toast_fontSize];
    msgLabel.numberOfLines = 0;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    
    //文字自适应宽高
    CGSize expectSize =  [msgLabel sizeThatFits:CGSizeMake(toastWidth, SCREEN_HEIGHT)];
    msgLabel.frame = CGRectMake((toastWidth -expectSize.width)/2, (toastHeight - expectSize.height)/2, expectSize.width, expectSize.height);
    [toastView addSubview:msgLabel];

    
}

//- (UIWindow *)getCurrentWindow{
//    NSArray *windows = [UIApplication sharedApplication].windows;
//    for (UIWindow *window in [windows reverseObjectEnumerator]) {
//        if ([window isKindOfClass:[UIWindow class]] && CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)) {
//            return window;
//        }
//    }
//    return [UIApplication sharedApplication].keyWindow;
//}




- (CGSize)getToastSizeWithMessage:(NSString *)msg{
    UIFont *font = [UIFont systemFontOfSize:toast_fontSize];
    CGSize textSize = MultilineTextSize(msg, font, CGSizeMake(SCREEN_WIDTH -60, SCREEN_HEIGHT));
    CGFloat labelWidth = textSize.width+10;
    CGFloat labelHeight = textSize.height+5;
    CGFloat heightPadding = 2 * toast_padding;
    CGFloat toastHeight = labelHeight + heightPadding;
    CGFloat toastWidth = labelWidth + heightPadding;
    return CGSizeMake(toastWidth, toastHeight);
}


- (void)finishDismiss{
    [UIView animateWithDuration:ANIM_DURATION animations:^{
            if(self.toastView){
                self.toastView.alpha = 0;
            }
    }];
    
    dismissTimer =  [NSTimer scheduledTimerWithTimeInterval:ANIM_DURATION target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
}

- (void)dismiss{
    [self removeToast];
    if(self.finishHandler){
        self.finishHandler();
    }
}

- (void)removeToast{
    if(toastView){
        [toastView removeFromSuperview];
        toastView = nil;
    }
}

- (void)dealloc{
    if(toastTimer){
        [toastTimer invalidate];
        toastTimer  = nil;
    }
    if(dismissTimer){
        [dismissTimer invalidate];
        dismissTimer = nil;
    }
}


@end
