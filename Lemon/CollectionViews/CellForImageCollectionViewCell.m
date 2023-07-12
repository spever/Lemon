//
//  CellForImageCollectionViewCell.m
//  Lemon
//
//  Created by luo on 2023/7/7.
//

#import "CellForImageCollectionViewCell.h"

@interface CellForImageCollectionViewCell ()
@property(nonatomic,strong) UIImageView *imgView;

@end

@implementation CellForImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.imgView = [[UIImageView alloc] init];
        [self addSubview:_imgView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame = self.bounds;
//    self.imgView.backgroundColor = [UIColor cyanColor];
    
}

- (void)setString:(NSString *)string{
    _string = [string copy];
    self.imgView.image = [UIImage imageNamed:string];
}

@end
