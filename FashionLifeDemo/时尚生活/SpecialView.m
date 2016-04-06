//
//  SpecialView.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "SpecialView.h"
#import "Header.h"
#import "SpecialCell.h"
#import "SpecialModel.h"
#import "MJRefresh.h"

@interface SpecialView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *specialArray;

@end

@implementation SpecialView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50 - 48) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        self.tableView.rowHeight = kScreenWidth/750*460;
        [self addSubview:_tableView];
        
        
        // 注册cell
        [self.tableView registerClass:[SpecialCell class] forCellReuseIdentifier:@"special"];
        
        
        // 加载数据
        [self setDataWithURL:kSpecialUrl];
        
        
        // 上拉刷新
        __weak typeof(self) BlockSelf = self;
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            BlockSelf.specialArray = [NSMutableArray array];
            [BlockSelf setDataWithURL:kSpecialUrl];
            [BlockSelf.tableView reloadData];
            [BlockSelf.tableView.header endRefreshing];
        }];
    }
    return self;
}


#pragma mark -  解析数据
- (void)setDataWithURL:(NSString *)url{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
        if (data == nil) {
            return ;
        }
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.specialArray = [SpecialModel modelWithDic:dic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    }] resume];
}

#pragma mark - 返回多少分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.specialArray.count;
}


#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"special" forIndexPath:indexPath];
    
    // 找到model
    SpecialModel *specialModel = self.specialArray[indexPath.row];
    cell.specialModel = specialModel;
    return cell;
    
}


#pragma mark - 选中cell跳转到详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpecialModel *specialModel = self.specialArray[indexPath.row];
    [self.delegate passDataWithAccess_url:specialModel.access_url];
}
@end
