//
//  NineGridViewController.m
//  Lemon
//
//  Created by luo on 2023/7/10.
//

#import "NineGridViewController.h"
#import <UIScrollView+MJRefresh.h>
#import <MJRefresh.h>
#import "UIDevice+StateHeight.h"

@interface NineGridViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation NineGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTitlebar];
    [self addCollectionView];
}


-(void)addTitlebar{
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, [UIDevice dev_statusBarHeight],self.view.frame.size.width, 44)];
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, 24, 24);
    [leftItem setBackgroundImage:[UIImage imageNamed:@"icon_arrow_left"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    [navBar pushNavigationItem:self.navigationItem animated:NO];
    
    [self.view addSubview:navBar];
}


/**添加collectionview,并增加刷新控件*/
-(void)addCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize=CGSizeMake(100, 100);
    layout.minimumLineSpacing=80;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,([UIDevice dev_statusBarHeight]+44), self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    
    _collectionView.delegate=self;
    _collectionView.dataSource =self;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:_collectionView];
    
   __weak typeof(self) weakself =self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakself.collectionView.mj_header endRefreshing];
        });
        
    }];
//    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [weakself.collectionView.mj_footer endRefreshing];
//        });
//
//    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}


-(void)loadMoreData{
    
    [self.collectionView.mj_footer performSelector:@selector(endRefreshing) withObject:nil afterDelay:3];
}

-(void)endRefreshing{
    [self.collectionView.mj_footer endRefreshing];
}

-(void)leftBarBtnClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
