//
//  ShopDetailView.h
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@protocol ShopDetailviewDelegate <NSObject>

- (void)changeHeight:(CGFloat)height;
- (void)passDataWithCode:(NSString *)code;

@end

@interface ShopDetailView : UIView
@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) CGFloat categoryHeight;
@property (nonatomic,assign) id<ShopDetailviewDelegate>delegate;
@end
