//
//  ShopController.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

typedef NS_ENUM(NSInteger,SkipToShop){
    SkipToShopFist,
    SkipToShopCategory
};

@interface ShopController : UIViewController
@property (nonatomic,copy) NSString *url;
@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *childrenName;
@property (nonatomic,copy) NSString *logo_url;
@property (nonatomic,assign) SkipToShop skipToShop;

@end
