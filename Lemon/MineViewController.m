//
//  MineViewController.m
//  Lemon
//
//  Created by luo on 2023/6/21.
//

#import "MineViewController.h"
#import "MenuItem.h"
#import "HomeTagDetailPageViewController.h"
#import "ImageTitleDescTableViewCell.h"
#import <Masonry.h>

@interface MineViewController ()

@property(nonatomic,strong) UIRefreshControl *refreshVc;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger pageSize;

@end

@implementation MineViewController

NSMutableArray *myData;

typedef void(^GTListLoaderMenuFinishBlock)(NSError *error,NSMutableArray *array);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pageSize = 1;
//    myData = [[NSMutableArray alloc] initWithObjects:
//    @"Data 1 in array",@"Data 2 in array",@"Data 3 in array",@"Data 4 in array",
//    @"Data 5 in array",@"Data 6 in array",@"Data 7 in array",@"Data 8 in array",
//    @"Data 9 in array",@"Data 10 in array",@"Data 11 in array",@"Data 12 in array",
//    nil];
    
    myData = @[].mutableCopy;
    [self addTableView];
    [self bindRefreshVc:_tableView];
    [self loadData:_pageSize];
    
}

-(void)bindRefreshVc:(UITableView *) tableView{
    _refreshVc = [[UIRefreshControl alloc] init];
    _refreshVc.tintColor = [UIColor redColor];
    _refreshVc.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开下拉刷新"];
    [_refreshVc addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    tableView.refreshControl = _refreshVc;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [myData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellID";
    ImageTitleDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[ImageTitleDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//
//    [_tableView registerClass:[ImageTitleDescTableViewCell class] forCellReuseIdentifier:cellIdentifier];
//    ImageTitleDescTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    NSString *stringForCell;
//    if(indexPath.section == 0){
//        stringForCell = [myData objectAtIndex:indexPath.row];
//    }else if (indexPath.section == 1){
//        stringForCell = [myData objectAtIndex:indexPath.row + [myData count]/2 ];
//    }
//    [cell.textLabel setText:stringForCell];
//    [cell.detailTextLabel setText:@"hello"];
//    [cell.imageView setImage:[UIImage imageNamed:@"icon_arrow_left"]];
    
    [cell setItem:myData[indexPath.row]];
    return  cell;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSString *headerTitle;
//    if(section == 0){
//        headerTitle = @"Section 1 Header";
//    }else{
//        headerTitle  =@"Section 2 Header";
//    }
//    return headerTitle;
//}
//
//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    NSString *footerTitle;
//    if( section == 0){
//        footerTitle = @"Section 1 Footer";
//    }else{
//        footerTitle = @"Section 2 Footer";
//    }
//    return footerTitle;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;
}




- (void)addTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
//    _tableView.backgroundColor = [UIColor yellowColor];
    _tableView.dataSource = self;
    _tableView.delegate =self;
    [self.view addSubview:_tableView];
    
}

-(void)loadData:(NSInteger)pageSize{
    [self loadListMenuWith:(NSInteger) pageSize completion:^(NSError *error, NSMutableArray *array) {
        if (error ==nil) {
            [self->_tableView reloadData];
            NSLog(@"data is ok");
            MenuItem *item = array.firstObject;
            NSLog(@"item----%@",item.title);
            self.pageSize++;
        } else {
            
        }
            
    }];
}


-(void)loadListMenuWith:(NSInteger)pageSize completion:(GTListLoaderMenuFinishBlock)finishBlock{
    NSLog(@"data loading...");
    NSString *urlString =[NSString stringWithFormat: @"https://www.qubaobei.com/ios/cf/dish_list.php?stage_id=1&limit=20&page=%ld",pageSize];
    NSLog(@"url -------- %@",urlString);
    NSError * _Nullable err;
    NSURL *listUrl = [NSURL URLWithString:urlString];
    __weak typeof(self)weakSelf=self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        NSError * jsonError;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        NSArray *dataArray = [jsonObject objectForKey:@"data"];
        
        NSLog(@"list---%@",dataArray);
        
        if(data == nil || [dataArray isEqual:[NSNull null]]){
            return;
        }
        
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary *info in dataArray) {
          
            MenuItem *item = [[MenuItem alloc] initValueWithDictionary:info];
            [listItemArray addObject:item];
//            [myData addObject:[info valueForKey:@"title"] ];
        }
        [myData addObjectsFromArray:listItemArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(finishBlock){
                finishBlock(nil,listItemArray);
            }
                    NSLog(@"loading finished");

        });
    }];
    
    [dataTask resume];
    
    
}


#pragma mark -- TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"section:%ld Row:%ld selected and its data is %@",indexPath.section,indexPath.row,cell.textLabel.text);
    HomeTagDetailPageViewController *vc = [[HomeTagDetailPageViewController alloc] init];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [vc setItemData:((MenuItem *)[myData objectAtIndex:indexPath.row]).food_str];
    
 //  //delegate传递数据
//    self.mDelegate = vc;
//    [self.mDelegate sendValue:cell.textLabel.text];
    

   
    [self presentViewController:vc animated:YES completion:^{
            
    }];
    
}

//- (void)transData:(void (^)(NSString * _Nonnull))block{
//    NSString *str = @"trans data with block";
//    self.transBlock = block;
//}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)sendValue:(NSString *)value{
    
}

-(void)onRefresh{
    [self performSelector:@selector(handlerData) withObject:nil afterDelay:1.5];
}

-(void)handlerData{
    [self loadData:_pageSize];
    [_refreshVc endRefreshing];

}

@end
