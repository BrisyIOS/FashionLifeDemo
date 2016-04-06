//
//  TarentoTableViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "TarentoTableViewCell.h"

@implementation TarentoTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 230, 50)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
      
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 49, 230, 1)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineLabel];
        
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
