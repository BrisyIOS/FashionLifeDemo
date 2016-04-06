//
//  ShopCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"

@interface ShopCell : UICollectionViewCell
@property (nonatomic,strong) ShopModel *shopModel;
@property (nonatomic,assign) BOOL isBrand;
@end
