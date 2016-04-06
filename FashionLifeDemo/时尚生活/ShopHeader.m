//
//  ShopHeader.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "ShopHeader.h"
#import "Header.h"

@interface ShopHeader ()


@end

@implementation ShopHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        int height = 40;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        self.label.textColor = [UIColor grayColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:18];
        [self.contentView  addSubview:_label];
        
    }
    return self;
}
@end
