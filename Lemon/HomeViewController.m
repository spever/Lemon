//
//  HomeViewController.m
//  Lemon
//
//  Created by luo on 2023/6/21.
//

#import "HomeViewController.h"
#import "ToastUtils.h"
#import "HomeTagDetailPageViewController.h"
#import "NineGridViewController.h"
#import <Masonry.h>
#import "UIDevice+StateHeight.h"


@interface HomeViewController ()

@property(nonatomic,strong) UIScrollView *scroll;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addScrollView];

    [self addTextField];
    [self addTextFieldWithDifferentKeyboard];
    [self addDifferentButtonType];
    [self addImage];
    NSLog(@"dev_statusBarHeight---%f",[UIDevice dev_statusBarHeight]);
    NSLog(@"dev_tabBarHeight---%f",[UIDevice dev_tabBarHeight]);
    NSLog(@"dev_safeDistanceTop---%f",[UIDevice dev_safeDistanceTop]);
    NSLog(@"dev_safeDistanceBottom---%f",[UIDevice dev_safeDistanceBottom]);
    NSLog(@"dev_navigationBarHeight---%f",[UIDevice dev_navigationBarHeight]);
    NSLog(@"dev_navigationFullHeight---%f",[UIDevice dev_navigationFullHeight]);
    NSLog(@"dev_tabBarFullHeight---%f",[UIDevice dev_tabBarFullHeight]);

    [self addNavigation];
    
    NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSLog(@"home%@",homePath);
    DevLog(@"home%@",homePath);
    

}

-(void)addScrollView{
    self.scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.scroll.contentSize =CGSizeMake(0, self.view.frame.size.height+120);
    [self.view addSubview:self.scroll];

}


/**
*增加导航栏**/
-(void)addNavigation{
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 600,self.view.frame.size.width, 44)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    //在这个集合Item中添加标题，按钮
    //style:设置按钮的风格，一共有三种选择
    //action：@selector:设置按钮的点击事件
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)];
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightButton)];
    
    //设置导航栏的内容
    [navItem setTitle:@"图灵工作室"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:leftButton];
    [navItem setRightBarButtonItem:rightButton];
    
    //将标题栏中的内容全部添加到主视图当中
    [self.scroll addSubview:navBar];
    
}


-(void)addTextField{
    UILabel *prefixLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    prefixLabel.text=@"##";
    [prefixLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [prefixLabel sizeToFit];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 280, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [textField setFont:[UIFont boldSystemFontOfSize:12]];
    textField.placeholder=@"Simple text field";
    textField.leftView=prefixLabel;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.scroll addSubview:textField];
    textField.delegate=(id)self;
    
}

-(void) addTextFieldWithDifferentKeyboard{

   UITextField *textField1= [[UITextField alloc]initWithFrame:
   CGRectMake(20, 100, 280, 30)];
   textField1.delegate = self;
   textField1.borderStyle = UITextBorderStyleRoundedRect;
   textField1.placeholder = @"Default Keyboard";
   [self.scroll addSubview:textField1];

   UITextField *textField2 = [[UITextField alloc]initWithFrame:
   CGRectMake(20, 150, 280, 30)];
   textField2.delegate = self;
   textField2.borderStyle = UITextBorderStyleRoundedRect;
   textField2.keyboardType = UIKeyboardTypeASCIICapable;
   textField2.placeholder = @"ASCII keyboard";
   [self.scroll addSubview:textField2];

   UITextField *textField3 = [[UITextField alloc]initWithFrame:
   CGRectMake(20, 200, 280, 30)];
   textField3.delegate = self;
   textField3.borderStyle = UITextBorderStyleRoundedRect;
   textField3.keyboardType = UIKeyboardTypePhonePad;
   textField3.placeholder = @"Phone pad keyboard";
   [self.scroll addSubview:textField3];

   UITextField *textField4 = [[UITextField alloc]initWithFrame:
   CGRectMake(20, 250, 280, 30)];
   textField4.delegate = self;
   textField4.borderStyle = UITextBorderStyleRoundedRect;
   textField4.keyboardType = UIKeyboardTypeDecimalPad;
   textField4.placeholder = @"Decimal pad keyboard";
   [self.scroll addSubview:textField4];

   UITextField *textField5= [[UITextField alloc]initWithFrame:
   CGRectMake(20, 300, 280, 30)];
   textField5.delegate = self;
   textField5.borderStyle = UITextBorderStyleRoundedRect;
   textField5.keyboardType = UIKeyboardTypeEmailAddress;
   textField5.placeholder = @"Email keyboard";
   [self.scroll addSubview:textField5];

   UITextField *textField6= [[UITextField alloc]initWithFrame:
   CGRectMake(20, 350, 280, 30)];
   textField6.delegate = self;
   textField6.borderStyle = UITextBorderStyleRoundedRect;
   textField6.keyboardType = UIKeyboardTypeURL;
   textField6.placeholder = @"URL keyboard";
   [self.scroll addSubview:textField6];
}


-(void)addDifferentButtonType{

    
    UIButton *infoRectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [infoRectBtn setFrame:CGRectMake(60, 450, 200, 40)];
    infoRectBtn.layer.cornerRadius = 20;
    infoRectBtn.layer.borderWidth=1;
    infoRectBtn.layer.borderColor = [UIColor blackColor].CGColor;
    infoRectBtn.backgroundColor = [UIColor systemPinkColor];
    [infoRectBtn setImage:[UIImage imageNamed:@"icon_all"] forState:UIControlStateNormal];
    [infoRectBtn setTitle:@"Rounded Rect Button" forState:UIControlStateNormal];
    infoRectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, infoRectBtn.titleLabel.intrinsicContentSize.width, 0, -infoRectBtn.titleLabel.intrinsicContentSize.width);
    infoRectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -infoRectBtn.currentImage.size.width, 0, infoRectBtn.currentImage.size.width);
    
    UIView *v1 = [[UIView alloc] init];
    v1.backgroundColor = [UIColor yellowColor];
    [self.scroll addSubview:v1];
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        
        make.size.equalTo(self.view).sizeOffset(CGSizeMake(-100, -800));
    }];
    

    
    [self.scroll addSubview:infoRectBtn];
    [infoRectBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
       
    UIButton *infoLightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoLightButton setFrame:CGRectMake(60, 500, 200, 40)];
    [infoLightButton addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll addSubview:infoLightButton];


}

-(void)addImage{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_all"]];
//    iv.frame = CGRectMake(60, 550, 40, 40);
    [iv setFrame:CGRectMake(60, 550, 40, 40)];
    iv.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage:)];
    [iv addGestureRecognizer:tap];
    [self.scroll addSubview:iv];
}


/** *方式二:::利用约束自动计算UIScrollView的contentsize**/
-(void)autoCalculateHeight{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
       [self.view addSubview:scrollView];
       scrollView.showsHorizontalScrollIndicator = NO;
       scrollView.alwaysBounceVertical = YES;
       scrollView.backgroundColor = [UIColor whiteColor];
       // 先不设置 contentSize.毕竟子视图有多长还不知道
       //scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, xxxx);
       
       /**
        
           不把 scrollView 的 contentSize 写死,.
           而是在其内部放一个uiview.
           在 uiview 内部添加子视图,用约束设置.
           根据内部约束的子视图计算 uiview 的大小.
           然后根据 uiview 的大小设置 scrollView 的 contentSize.
        */
       
       /**
           现在的做法:
           记录每一个子视图的高度记忆边距数据,然后累加起来.
        */
       UIView *containerView = [[UIView alloc] init];
       // 容器,只设置 x,y,w  高度 h 先不设置,用子视图的约束去计算
       [scrollView addSubview:containerView];
       [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.top.offset(0);
           make.width.equalTo(scrollView.mas_width);
       }];
       
       
       UIView *childView1 = [[UIView alloc] init];
       [containerView addSubview:childView1];
       childView1.backgroundColor = [UIColor blueColor];
       
       [childView1 mas_makeConstraints:^(MASConstraintMaker *make) {
           // 头部约束
           make.top.offset(20);
           make.left.offset(0);
           make.width.equalTo(containerView.mas_width);
           make.height.offset(300);
           
       }];
       
       UIView *childView2 = [[UIView alloc] init];
       [containerView addSubview:childView2];
       childView2.backgroundColor = [UIColor greenColor];
       
       [childView2 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.offset(0);
           make.top.equalTo(childView1.mas_bottom).offset(50);
           make.height.offset(400);
           make.width.equalTo(containerView.mas_width);
           
       }];

       
       UIView *childView3 = [[UIView alloc] init];
       [containerView addSubview:childView3];
       childView3.backgroundColor = [UIColor redColor];
       
       [childView3 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.offset(0);
           make.top.equalTo(childView2.mas_bottom).offset(100);
           make.width.equalTo(containerView.mas_width);
           make.height.offset(700);
           
           // 底部约束,用于计算containerView 的 height
          make.bottom.offset(-50);
       }];

       // 不用去调用约束立即计算的代码,有个小技巧,使用 dispatch_after 即可拿到约束计算完毕之后的 containerView 的height 值.
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           NSLog(@"%.f",containerView.frame.size.height);
           scrollView.contentSize = CGSizeMake(self.view.frame.size.width, containerView.frame.size.height);
       });

}







#pragma mark ---按钮响应方法
-(void)btnAction:(UIButton *)btn{
    NSLog(@"点击了按钮了！！");
    HomeTagDetailPageViewController *detailVc = [[HomeTagDetailPageViewController alloc] init];
    detailVc.modalPresentationStyle =   UIModalPresentationFullScreen;

//    [self presentViewController:detailVc animated:YES completion:^{
//        NSLog(@"---------");
//    }];
    [self.navigationController pushViewController:detailVc animated:YES];

}

-(void)btnTap:(id)sender{
    NineGridViewController *vc = [[NineGridViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}



-(void)onClickImage:(UIImageView *)iv{
    NSLog(@"img clicked！！");
    [[ToastUtils toast] showToast:@"在实际开发中，想要实现类似于Android系统自带的Toast弹出信息提示窗，那么该如何实现呢？相信大家对于windows窗口并不陌生，此处的实现思路是利用UIApplication中windows窗口添加视图，设置定时消失实现类似于Android系统自带Toast弹出信息提示窗"];
}

-(void)showDialog:(NSString *)str
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"我是标题" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
  
-(void) clickLeftButton
{
    [self showDialog:@"点击了导航栏左边按钮"];
}
  
-(void) clickRightButton
{
    [self showDialog:@"点击了导航栏右边按钮"];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
