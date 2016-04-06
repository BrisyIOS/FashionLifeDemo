//
//  CategoryView.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryViewDelegate <NSObject>

- (void)passDataWithCategoryCode:(NSString *)code ChildrenName:(NSString *)childrenName categoryArray:(NSMutableArray *)categoryArray IndexPath:(NSIndexPath *)indexPath name:(NSString *)name;

@end

@interface CategoryView : UIView
@property (nonatomic,assign) id<CategoryViewDelegate>delegate;

@end
