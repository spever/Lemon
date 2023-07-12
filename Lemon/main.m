//
//  main.m
//  Lemon
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

typedef void (^NewType) (int arg1,NSString *arg2);

void (^testBlock)(int, NSString *)=^(int age,NSString *name){
    NSLog(@"%@",name);
};



NewType t = ^(int age,NSString *name){
    NSLog( @"名字是%@，今年%d岁",name,age);
};

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//
//        testBlock(3,@"hello");
//        t(2,@"boy");
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}


