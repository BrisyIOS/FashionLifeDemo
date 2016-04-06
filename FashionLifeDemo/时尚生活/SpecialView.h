//
//  SpecialView.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpecialViewDelegte <NSObject>

- (void)passDataWithAccess_url:(NSString *)access_url;

@end

@interface SpecialView : UIView
@property (nonatomic,assign) id<SpecialViewDelegte>delegate;


@end
