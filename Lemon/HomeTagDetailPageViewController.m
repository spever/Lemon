//
//  HomeTagDetailPageViewController.m
//  Lemon
//
//  Created by luo on 2023/7/3.
//

#import "HomeTagDetailPageViewController.h"

@interface HomeTagDetailPageViewController ()

@property(nonatomic,copy) NSString *data;

@end

@implementation HomeTagDetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self addTitlebar];
    
    [self AddSwitchButton];
    
    NSLog(@"out-------trans   %@",_itemData);
    
//    MineViewController *m = [[MineViewController alloc] init];
//    [m transData:^(NSString * _Nonnull str) {
//        NSLog(@"out---%@",str);
//        self.data = str;
//    }];
    
    [self AddLabel:_itemData];
    
}


- (void)addTitlebar{
    UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_arrow_left"]];
    [iv setFrame:CGRectMake(10, 50, 48, 48)];
    [iv setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconDidTap:)];
    [iv addGestureRecognizer:tap];
    [self.view addSubview:iv];

}

-(void)AddSwitchButton{
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(50, 100, 20, 10)];
    [switchBtn setOn:YES];
    [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    self.view.backgroundColor = [UIColor systemPinkColor];
    [self.view addSubview:switchBtn];
}

-(void)AddLabel:(NSString*) str{
    UILabel *lab = [[UILabel alloc] init];
    lab.text = str;
    lab.textColor = [UIColor blackColor];
    lab.center =self.view.center;
    lab.frame = CGRectMake(50, 200, 300, 100);
    lab.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)switchAction:(id)sender{
    UISwitch *switcbtn = (UISwitch *)sender;
    BOOL isOn = [switcbtn isOn];
    if(isOn){
        NSLog(@"我裂开了");
    }else{
        NSLog(@"我闭合了");
        
        if(self.block){
            _block(@"我闭合了");
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)iconDidTap:(id)sender{
   [ self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"Closed");
   }];
}

- (void)sendValue:(NSString *)value{
    NSLog(@"传递过来的值为：%@", value);
    [self AddLabel:value];
}


//- (void)receiveData:(TransWithData)transBlock{
//    self.block = transBlock;
//}

- (void)setData:(NSString *)data{
    self.data = data;
}


@end
