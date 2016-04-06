//
//  HomeView.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeViewDelegate <NSObject>

- (void)passWithURL:(NSString *)url ID:(NSString *)ID name:(NSString *)name;

@end

@interface HomeView : UIView
@property (nonatomic,assign) id<HomeViewDelegate>delegate;
@end
