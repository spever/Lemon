//
//  ClassRoomViewController.m
//  Lemon
//
//  Created by luo on 2023/6/21.
//

#import "ClassRoomViewController.h"
#import "HomeTagDetailPageViewController.h"
#import "CollectionViews/ContainerScrollerLayout.h"
#import "CollectionViews/CellForImageCollectionViewCell.h"
#import "UIDevice+StateHeight.h"
#import <Masonry.h>

@interface ClassRoomViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) ContainerScrollerLayout *flowLayout;
@property(nonatomic,strong) NSMutableArray *arrsPhotos;
@property(nonatomic,strong) UIPageControl *page;
@property(nonatomic,strong) NSTimer *timer;

@end

@implementation ClassRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,100,200)];
//    [self.view addSubview:view];
//    view.backgroundColor = [UIColor blueColor];
    [self addToolbar];
    [self addLabel];
    [self arrayOfPhotos];
    [self createCollectionView];
    [self addPageControl];
    [self addNSTimer];
}
-(void)addToolbar
{
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil action:nil];
    UIBarButtonItem *customItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Preview"
                                                            style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(toolBarItem1:)];
    UIBarButtonItem *customItem2 = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                            style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(toolBarItem2:)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:customItem1,spaceItem, customItem2, nil];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, [UIDevice dev_statusBarHeight]+60, self.view.frame.size.width, 50)];
    [toolbar setBarStyle:UIBarStyleDefault];
    [toolbar setItems:toolbarItems];
    [self.view addSubview:toolbar];
}
//
-(IBAction)toolBarItem1:(id)sender{
    [self.label setText:@"Tool 1 Selected"];
}

-(IBAction)toolBarItem2:(id)sender{
    [self.label setText:@"Tool 2 Selected"];
    
    HomeTagDetailPageViewController *vc = [[HomeTagDetailPageViewController alloc] init];
    vc.block = ^(NSString * _Nonnull str) {
        self.label.text = str;
    };
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)addLabel{
    if(!self.label){
       self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 80)];
    }

    self.label.text=@"This is a sample text of mulitple lines.here number of lines is not limited.";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines=0;
    self.label.textColor = [UIColor redColor];
    self.label.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.label];
}

- (NSArray *)arrayOfPhotos{
    if(!_arrsPhotos){
        _arrsPhotos = [NSMutableArray array];
        for (int i=1; i<11; i++) {
            NSString *photoName = [NSString stringWithFormat:@"%d",i];
            [_arrsPhotos addObject:photoName];
        }
    }
    return _arrsPhotos;
}


- (void)addPageControl {
    self.page = [[UIPageControl alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.page];
    self.page.numberOfPages = self.arrsPhotos.count;
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.collectionView);
        make.top.equalTo(self.collectionView.mas_bottom).offset(-25);
    }];
}

-(void)createCollectionView{
    self.flowLayout = [[ContainerScrollerLayout alloc] init];
    self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width * 9/16);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    [self.view addSubview:self.collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width * 9/16));
        make.top.equalTo(self.label.mas_bottom).offset(50);
    }];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.collectionView registerClass:[CellForImageCollectionViewCell class] forCellWithReuseIdentifier:@"cellpool"];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    self.collectionView.pagingEnabled=YES;
    self.collectionView.showsHorizontalScrollIndicator=NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrsPhotos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CellForImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellpool" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
//    [cell setString:_arrsPhotos[indexPath.item]];
    cell.string=_arrsPhotos[indexPath.item];
    return  cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark ----------- 定时器 --------------
-(void)addNSTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)removeNSTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)next{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathRest =  [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    NSInteger nextItem = currentIndexPath.item+1;
    NSInteger currentSection = currentIndexPathRest.section;
    if(nextItem ==self.arrsPhotos.count){
        nextItem=0;
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:currentSection];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }else{
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:currentSection];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    self.page.currentPage = nextItem;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeNSTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addNSTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width) % self.arrsPhotos.count;
    self.page.currentPage = page;
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
