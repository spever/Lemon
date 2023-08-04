//
//  ViewController.m
//  Lemon
//
//  Created by luo on 2023/6/19.
//

#import "ViewController.h"
#import "BaseTabViewController.h"
#import "HomeViewController.h"
#import "ClassRoomViewController.h"
#import "MineViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (UITabBarController *)initialContainer{
    
    //方式一
    //    UITabBarController *tabbar = [[UITabBarController alloc] init];

    //    UIViewController *nc1 = [[UIViewController alloc] init];
    //    nc1.tabBarItem.title=@"Message";
    //    nc1.view.backgroundColor=[UIColor grayColor];
    //
    //    UIViewController *nc2 = [[UIViewController alloc] init];;
    //    nc2.tabBarItem.title=@"Video";
    //    nc2.view.backgroundColor=[UIColor whiteColor];
    //
    //    UIViewController *nc3 = [[UIViewController alloc] init];
    //    nc3.tabBarItem.title=@"Mine";
    //    nc3.view.backgroundColor=[UIColor brownColor];
    //
    //    [tabbar setViewControllers:@[nc1,nc2,nc3]];
    //    tabbar.delegate =(id)self;
    //
    //    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:tabbar];
    //    self.window.rootViewController = unc;
    //    [self.window makeKeyAndVisible];

    //方式二
    //    HomeViewController *home = [[HomeViewController alloc] init];
    //    [home setupChildViewController:home title:@"首页" imageName:@"icon_all" selectedImageName:@"icon_all_in"];
    //    home.tabBarItem.badgeValue=@"2";
    //
    //    ClassRoomViewController *classRoom = [[ClassRoomViewController alloc]init];
    //    [classRoom setupChildViewController:classRoom title:@"课堂" imageName:@"icon_focus" selectedImageName:@"icon_focus_in"];
    //
    //    MineViewController *mine = [[MineViewController alloc] init];
    //    [mine setupChildViewController:mine title:@"我的" imageName:@"icon_config" selectedImageName:@"icon_config_in"];
    //
    //    tabbar.viewControllers = @[home,classRoom,mine];
    //    [self.window setRootViewController:tabbar];
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];

    HomeViewController *home = [[HomeViewController alloc] init];
   UINavigationController *NCHome =  [home setupChildViewController:home title:@"首页" imageName:@"icon_all" selectedImageName:@"icon_all_in"];
    home.tabBarItem.badgeValue=@"2";
    
    ClassRoomViewController *classRoom = [[ClassRoomViewController alloc]init];
    UINavigationController *NCRoom = [classRoom setupChildViewController:classRoom title:@"课堂" imageName:@"icon_focus" selectedImageName:@"icon_focus_in"];

    MineViewController *mine = [[MineViewController alloc] init];
    UINavigationController *NCMine =[mine setupChildViewController:mine title:@"我的" imageName:@"icon_config" selectedImageName:@"icon_config_in"];
    tabbar.viewControllers = @[NCHome,NCRoom,NCMine];
    return tabbar;
}


@end
