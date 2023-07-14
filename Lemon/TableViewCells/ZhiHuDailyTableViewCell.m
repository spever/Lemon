//
//  ZhiHuDailyTableViewCell.m
//  Lemon
//
//  Created by luo on 2023/7/14.
//

#import "ZhiHuDailyTableViewCell.h"
#import <SDWebImage.h>
#import <Masonry.h>

@implementation ZhiHuDailyTableViewCell

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
        self.iv = [[UIImageView alloc] init];
        self.title = [[UILabel alloc] init];
        self.title.textColor = [UIColor blueColor];
        self.title.numberOfLines=0;
        self.hint = [[UILabel alloc]init];
        self.hint.textColor = [UIColor darkGrayColor];
        self.hint.numberOfLines=0;
        [self.hint setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:self.iv];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.hint];

    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iv.mas_right).offset(20);
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    [_hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iv.mas_right).offset(20);
        make.top.equalTo(_title.mas_bottom).offset(15);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
}


/**
 * http://news-at.zhihu.com/api/4/news/latest
 * https://news-at.zhihu.com/api/3/sections
 */

- (void)setItem:(ZhihuNewsItem *)item{
    _item = item;
    NSString *picUrl=nil;
    if([item.images isEqual:[NSNull null]] || item.images ==nil){
        //
    }else{
        picUrl = item.images[0];
        [_iv sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"2"]];
    }
    _title.text = item.title;
    _hint.text  = item.hint;
}

@end

