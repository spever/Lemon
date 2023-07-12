//
//  UIDevice+StateHeight.m
//  Lemon
//
//  Created by luo on 2023/7/12.
//

#import "UIDevice+StateHeight.h"

@implementation UIDevice (StateHeight)

+ (CGFloat)dev_safeDistanceTop {
    if(@available(iOS 13.0,*)){
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *ws = [set anyObject];
        UIWindow *window = ws.windows.firstObject;
        return window.safeAreaInsets.top;
        
    }else if (@available(iOS 11.0,*)){
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return  window.safeAreaInsets.top;
    }
    return 0;
}

+ (CGFloat)dev_safeDistanceBottom {
    if(@available(iOS 13.0,*)){
        NSSet *set= [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *ws = [set anyObject];
        UIWindow *window = ws.windows.firstObject;
        return window.safeAreaInsets.bottom;
        
    }else if(@available(iOS 11.0,*)){
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
        
    }
    return 0;
}

+ (CGFloat)dev_statusBarHeight {
    if(@available(iOS 13.0,*)){
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *ws = [set anyObject];
        UIStatusBarManager *manager = ws.statusBarManager;
        return manager.statusBarFrame.size.height;
    }else{
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

+ (CGFloat)dev_navigationBarHeight {
    return 44.0f;
}

+ (CGFloat)dev_navigationFullHeight {
    return [UIDevice dev_statusBarHeight] + [UIDevice dev_safeDistanceBottom];
}

+ (CGFloat)dev_tabBarHeight {
    return 49.0f;
}


+ (CGFloat)dev_tabBarFullHeight {
    return  [UIDevice dev_statusBarHeight] + [UIDevice dev_navigationBarHeight];
}

@end
