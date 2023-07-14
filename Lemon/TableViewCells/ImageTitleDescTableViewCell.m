//
//  ImageTitleDescTableViewCell.m
//  Lemon
//
//  Created by luo on 2023/7/13.
//

#import "ImageTitleDescTableViewCell.h"
#import <Masonry.h>
#import <SDWebImage.h>

@interface ImageTitleDescTableViewCell ()


@end

@implementation ImageTitleDescTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _imageViewBig =  [[UIImageView alloc] initWithFrame:CGRectZero];
        _title = [[UILabel alloc]initWithFrame:CGRectZero];
        [_title setTextColor:[UIColor redColor]];
        _desc = [[UILabel alloc] initWithFrame:CGRectZero];
        [_desc setTextColor:[UIColor grayColor]];
        [_desc setFont:[UIFont systemFontOfSize:15]];
        [_desc setNumberOfLines:0];
        [self.contentView addSubview:_imageViewBig];
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_desc];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [_imageViewBig mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(20);
        make.top.equalTo(self.contentView).with.offset(20);
        make.bottom.equalTo(self.contentView).with.offset(-20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(80);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageViewBig.mas_right).with.offset(20);
        make.top.equalTo(self.contentView).with.offset(20);
//        make.width.mas_equalTo(240);
        make.height.mas_equalTo(40);
    }];
    
    [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageViewBig.mas_right).with.offset(20);
        make.top.equalTo(self.imageViewBig).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(-10);
//        make.width.mas_equalTo(150);
        make.height.mas_equalTo(80);
    }];
}


- (void)setItem:(MenuItem *)item{
    _item = item;
    [_imageViewBig sd_setImageWithURL:[NSURL URLWithString:item.pic] placeholderImage:[UIImage imageNamed:@"1"]];
    [_title setText:item.title];
    [_desc setText:item.food_str];
}

@end
