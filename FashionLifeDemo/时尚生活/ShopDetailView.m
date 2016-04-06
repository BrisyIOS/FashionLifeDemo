//
//  ShopDetailView.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "ShopDetailView.h"
#import "ShopHeader.h"
#import "Header.h"

@interface ShopDetailView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) BOOL isFold;
@property (nonatomic,strong) ShopHeader *header;

@end

@implementation ShopDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.scrollEnabled = NO;
        [self addSubview:_tableView];
        
        
        // 注册cell
        [self.tableView registerClass:[ShopHeader class] forHeaderFooterViewReuseIdentifier:@"header"];
    }
    return self;
}


#pragma mark - 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isFold) {
        return 40;
    }else{
        return 0;
    }
}

#pragma mark - 返回多少分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isFold) {
        return self.categoryArray.count;
    }
    return 0;
}


#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 找到model
    CategoryModel *model = self.categoryArray[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
    
    
}


#pragma mark - 更新表格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
    CategoryModel *categoryModel = self.categoryArray[indexPath.row];
    [self.delegate passDataWithCode:categoryModel.code];
    self.header.label.text = categoryModel.name;
    self.name = categoryModel.name;
    [self.delegate changeHeight:self.categoryHeight];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, self.categoryHeight);
    self.isFold = NO;

}


#pragma mark - 返回表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    ShopHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    header.label.text = self.name;
    self.header = header;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [header addGestureRecognizer:tap];
    
    return header;
}

#pragma mark - 实现轻拍手时
- (void)tapAction:(UITapGestureRecognizer *)tap{
    self.isFold = !self.isFold;
    
    if (self.isFold) {
        [self.delegate changeHeight:self.categoryHeight + self.categoryArray.count*self.categoryHeight];
        self.tableView.frame = CGRectMake(0, 0, kScreenWidth, self.categoryHeight*(self.categoryArray.count + 1));
    }else{
        [self.delegate changeHeight:self.categoryHeight];
        self.tableView.frame = CGRectMake(0, 0, kScreenWidth, self.categoryHeight);
    }
    
    [self.tableView reloadData];
}


#pragma mark - 返回表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.categoryHeight;
}
@end
