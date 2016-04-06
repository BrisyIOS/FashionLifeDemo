//
//  HomeView.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "HomeView.h"
#import "Header.h"
#import "OneCell.h"
#import "TwoCell.h"
#import "ThreeCell.h"
#import "FourCell.h"
#import "MJRefresh.h"
#import "CommonActivityIndicatorView.h"

@interface HomeView ()<UITableViewDataSource,UITableViewDelegate,OneCellDelegate,TwoCellDelegate,FourCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *storeArray;
@property (nonatomic,strong) CommonActivityIndicatorView *activityView;

@end

@implementation HomeView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50 - 48) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
        
        // 注册cell
        [self.tableView registerClass:[OneCell class] forCellReuseIdentifier:@"oneCell"];
        
        [self.tableView registerClass:[TwoCell class] forCellReuseIdentifier:@"twoCell"];
        
        
        [self.tableView registerClass:[ThreeCell class] forCellReuseIdentifier:@"threeCell"];
        
        
        [self.tableView registerClass:[FourCell class] forCellReuseIdentifier:@"fourCell"];
        
        
        // 加载数据
        [self setDataWithURL:kFirstUrl];
        
        
        // 上拉刷新
        __weak typeof(self) BlockSelf = self;
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            BlockSelf.activityView = [[CommonActivityIndicatorView alloc] init];
            [BlockSelf addSubview:BlockSelf.activityView];
            BlockSelf.storeArray = [NSMutableArray array];
            [BlockSelf setDataWithURL:kFirstUrl];
            [BlockSelf.tableView reloadData];
            [BlockSelf.tableView.header endRefreshing];
            
        }];
    }
    return self;
}


#pragma mark - 实现one Cell中的协议中的方法
- (void)passUrl:(NSString *)url topic_name:(NSString *)topic_name{
    [self.delegate passWithURL:url ID:@"one" name:topic_name];
}

#pragma mark - 实现one Cell中的协议中的方法
- (void)passContent_id:(NSString *)content_id{
    [self.delegate passWithURL:content_id ID:@"two" name:@"商店"];
}


#pragma mark - 实现twoCell 中协议中的方法
- (void)passDataWithContent_id:(NSString *)content_id{
    [self.delegate passWithURL:content_id ID:@"two" name:@"商店"];
}


#pragma mark - 实现twocell中协议中的方法
- (void)passDataWithtopic_url:(NSString *)topic_url topic_name:(NSString *)topic_name{
    [self.delegate passWithURL:topic_url ID:@"one" name:topic_name];
}


#pragma mark - 实现fourcell 中协议中的方法
- (void)passDataWithID:(NSString *)ID{
    [self.delegate passWithURL:ID ID:@"two" name:@"商店"];
}


#pragma mark - 请求数据
- (void)setDataWithURL:(NSString *)url{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *  data, NSURLResponse * response, NSError * error) {
        
        if (data == nil) {
            
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.storeArray = [NSMutableArray array];
        NSMutableArray *slideArray = [StoreModel modelObjectWithDictionary:dic];
        [self.storeArray addObject:slideArray];
        
        NSMutableArray *listArray = [StoreModel modelWithDic:dic];
        [self.storeArray addObjectsFromArray:listArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.activityView endCommonActivity];
        });
        
    }] resume];
}


#pragma mark - 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return kScreenWidth/750*446;
            break;
        case 1:
            return kScreenWidth/2 + kScreenWidth / 1.55;
            break;
        case 2:
            return kScreenWidth/750*446;
            break;
        case 3:
            return kScreenWidth/2;
            break;
        default:
            break;
    }
    return 0;
}


#pragma mark - 返回多少分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.storeArray.count;
}


#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    switch (indexPath.row) {
        case 0:
        {
            OneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.slderArray = self.storeArray[indexPath.row];
            cell.count = (int)cell.slderArray.count;
            [cell.collectionView reloadData];
            return cell;
        }
            break;
        case 1:
        {
            TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.listArray = self.storeArray[indexPath.row];
            [cell.collectionView reloadData];
            return cell;
        }
            break;
        case 2:
        {
            ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            cell.storeModel = self.storeArray[indexPath.row][0];
            return cell;
        }
            break;
        case 3:
        {
            FourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fourCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.FourArray = self.storeArray[indexPath.row];
            [cell.collectionView reloadData];
            return cell;
        }
            break;
        default:
            break;
    }

    return nil;
}


#pragma mark - 选中cell跳转到详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreModel *storeModel = self.storeArray[indexPath.row][0];
    if (indexPath.row == 2) {
        [self.delegate passWithURL:storeModel.content_id ID:@"two" name:@"商店"];
    }
}



@end
