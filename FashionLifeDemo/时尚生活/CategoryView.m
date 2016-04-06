//
//  CategoryView.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "CategoryView.h"
#import "Header.h"
#import "CategoryHeader.h"
#import "CategoryModel.h"
#import "MJRefresh.h"

@interface CategoryView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic,strong) NSMutableArray *coverArray;
@property (nonatomic,assign) BOOL isFold;// 是否展开
@property (nonatomic,assign) NSInteger section;
@property (nonatomic,strong) NSMutableArray *itemArray;

@end

@implementation CategoryView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50 - 48) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.rowHeight = 50;
        [self addSubview:_tableView];
        
        
        // 注册cell
        [self.tableView registerClass:[CategoryHeader class] forHeaderFooterViewReuseIdentifier:@"header"];
        
        
        // 加载数据
        [self setDataWithURL:kCategoryUrl];
        
        
        // 上拉刷新
        __weak typeof(self) BlockSelf = self;
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            BlockSelf.categoryArray = [NSMutableArray array];
            [BlockSelf setDataWithURL:kCategoryUrl];
            [BlockSelf.tableView.header endRefreshing];
        }];
        
    }
    return self;
}



#pragma mark - 解析数据
- (void)setDataWithURL:(NSString *)url{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * data, NSURLResponse *  response, NSError *  error) {
        if (data == nil) {
            return ;
        }
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSArray *itemArray = dataDic[@"items"];
        self.itemArray = [NSMutableArray array];
        [self.itemArray addObjectsFromArray:itemArray];
        self.categoryArray = [CategoryModel modelWithDic:dic];
        self.coverArray = [CoverModel modelWithDic:dic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView  reloadData];
        });
    }] resume];
}


#pragma  mark - 返回多少分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.categoryArray.count;
}


#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isFold) {
        if (section == self.section) {
            return [self.categoryArray[section] count];
        }
    }
    return 0;
}


#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    // 找到model
    CategoryModel *categoryModel = self.categoryArray[indexPath.section][indexPath.row];
    cell.textLabel.text = categoryModel.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - 选中cell 跳转到详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryModel *categoryModel = self.categoryArray[indexPath.section][indexPath.row];
    NSString *name = self.itemArray[indexPath.section][@"name"];
    [self.delegate passDataWithCategoryCode:categoryModel.code ChildrenName:categoryModel.name categoryArray:self.categoryArray[indexPath.section] IndexPath:indexPath name:name];
}


#pragma mark - 返回表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CategoryHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    // 为表头添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    [header addGestureRecognizer:tap];
    tap.view.tag = section;

    // 找到model
    CoverModel *coverModel = self.coverArray[section];
    header.coverModel = coverModel;
    return header;
}


#pragma mark - 返回表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScreenWidth/750*420;
}


#pragma mark - 轻拍手势
- (void)tapAction:(UITapGestureRecognizer *)tap{
    self.section = tap.view.tag;
     self.isFold = !self.isFold;
    [self.tableView reloadData];
}
@end
