//
//  Header.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


/***首页*****/
#define  kFirstUrl @"http://api.iliangcang.com/i/appshophome?app_key=Android&build=2015110402&v=1.0"

/****分类*******/
#define kCategoryUrl @"http://iliangcang.com:8200/good/categories?app_key=Android&build=2015110402"


/*****品牌*********/
#define kBrandUrl @"http://iliangcang.com:8200/brand/list/2?start=0&offset=20&app_key=Android&build=2015110402"

/*****专题**********/
#define kSpecialUrl @"http://api.iliangcang.com/i/appshopmaga?app_key=Android&build=2015110402&v=1.0"



#endif /* Header_h */
