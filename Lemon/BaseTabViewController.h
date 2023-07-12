//
//  BaseTabViewController.h
//  Lemon
//
//  Created by luo on 2023/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabViewController : UIViewController

- (UINavigationController *)setupChildViewController:(UIViewController *)childVc
                           title:(NSString *)title
                       imageName:(NSString *)imageName
               selectedImageName:(NSString *)selectedImageName;

@end

NS_ASSUME_NONNULL_END
