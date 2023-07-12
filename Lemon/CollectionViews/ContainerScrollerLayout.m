//
//  ContainerScrollerLayout.m
//  Lemon
//
//  Created by luo on 2023/7/7.
//

#import "ContainerScrollerLayout.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation ContainerScrollerLayout

- (instancetype)init{
    if(self = [super init]){
        self.itemSize = CGSizeMake(WIDTH, 300);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

@end
