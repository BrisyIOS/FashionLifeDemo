//
//  MagazineController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MagazineController.h"
#import "MagazineModel.h"
#import "MagazineCell.h"
#import "MagezineHeader.h"
#import "MagazineDetailController.h"
#import "MagazineWebController.h"
#import "Header.h"
#import "DIYButton.h"
#import "CommonActivityIndicatorView.h"

@interface MagazineController ()

@property (nonatomic, strong) UILabel *todayLabel;
@property (nonatomic, strong) NSMutableArray *infosArray;
@property (nonatomic, strong) NSMutableArray *keysArray;
@property (nonatomic, strong) DIYButton *titleBtn;
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) NSString *authorStr;
@property (nonatomic, strong) NSString *nowUrl;
@property (nonatomic,strong) CommonActivityIndicatorView *activityView;

@end

static NSString *cellIdentifier = @"cell";

@implementation MagazineController
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.translucent = NO;
    
    // 请求数据
    [self getMagazine];
    
    // 创建label和Button
    [self createLabelAndButton];
    
    // 设置row的高度
    self.tableView.rowHeight = kScreenHeight/3.0;
    // 注册
    [self.tableView registerClass:[MagazineCell class] forCellReuseIdentifier:cellIdentifier];
    // 清除白线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册header
    [self.tableView registerClass:[MagezineHeader class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    self.activityView = [[CommonActivityIndicatorView alloc] init];
    [self.view addSubview:_activityView];
}
#pragma mark -- 创建label和Button --
- (void)createLabelAndButton
{
    
    if (self.isClassify || self.isAuthor) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 60, 30);
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBar;
        
        if (self.isClassify) {
            NSString *classifyStr = [NSString stringWithFormat:@"杂志•%@", self.cat_name];
            CGRect bounds = [classifyStr boundingRectWithSize:CGSizeMake(kScreenWidth, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16]forKey:NSFontAttributeName] context:nil];
            self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width+15, 30)];
            self.titleBtn = [[DIYButton alloc] initWithFrame:self.myView.frame];
            self.titleBtn.tlLabel.text = classifyStr;
            
        } else {
            
            self.authorStr = [NSString stringWithFormat:@"杂志•%@", self.author_name];
            CGRect bounds = [self.authorStr boundingRectWithSize:CGSizeMake(kScreenWidth, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16]forKey:NSFontAttributeName] context:nil];
            self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width+15, 30)];
            self.titleBtn = [[DIYButton alloc] initWithFrame:self.myView.frame];
            self.titleBtn.tlLabel.text = self.authorStr;
        }
    } else {
        
        // 创建label
        self.todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        self.todayLabel.textAlignment = NSTextAlignmentLeft;
        UIBarButtonItem *labelBar = [[UIBarButtonItem alloc] initWithCustomView:self.todayLabel];
        self.navigationItem.leftBarButtonItem = labelBar;
        self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        self.titleBtn = [[DIYButton alloc] initWithFrame:self.myView.frame];
        self.titleBtn.tlLabel.text = @"杂志";
    }
    
    // 创建navigationItem.title
    self.titleBtn.tlLabel.textColor = [UIColor blackColor];
    self.titleBtn.tlLabel.font = [UIFont systemFontOfSize:16];
    self.titleBtn.iconImageView.image = [UIImage imageNamed:@"down"];
    [self.titleBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.myView addSubview:self.titleBtn];
    self.navigationItem.titleView = self.myView;
   
}
#pragma mark -- 返回到杂志首页 --
- (void)backBtn:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.isAuthor = NO;
    self.isClassify = NO;
}
#pragma mark -- 跳转到菜单页--
- (void)buttonAction
{
    self.hidesBottomBarWhenPushed = YES;
    MagazineDetailController *detailVc = [[MagazineDetailController alloc] init];
    if (self.isAuthor) {
        detailVc.isAuthor = YES;
    }
    [self.navigationController pushViewController:detailVc animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark -- 数据请求 --
- (void)getMagazine
{
    if (self.isClassify || self.isAuthor) {
        self.nowUrl = self.url;
    } else {
        self.nowUrl = @"http://app.iliangcang.com/topic/listinfo?app_key=Android&build=2015110402&v=1.0";
    }
    // 数据请求解析
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:self.nowUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data == nil) {
            return ;
        }
        
        self.keysArray = [NSMutableArray array];
        self.infosArray = [NSMutableArray array];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSDictionary *infosDic = dataDic[@"infos"];
        
        self.keysArray = dataDic[@"keys"];
        
        for (int i = 0; i < self.keysArray.count; i++) {
            
            NSMutableArray *subArray = [NSMutableArray array];
            for (NSDictionary *subDic in [infosDic objectForKey:self.keysArray[i]]) {
                MagazineModel *model = [[MagazineModel alloc] init];
                [model setValuesForKeysWithDictionary:subDic];
                [subArray addObject:model];
            }
            [self.infosArray addObject:subArray];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程刷新UI
            [self.tableView reloadData];
            [self.activityView endCommonActivity];
        });
    }];
    [dataTask resume];
}
#pragma mark -- 返回分区 --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.infosArray.count;
}
#pragma mark -- 返回cell个数 --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.infosArray[section] count];
}
#pragma mark -- 返回cell --
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.todayLabel.text = [self.keysArray[indexPath.section] substringFromIndex:5];
    MagazineModel *model = [self.infosArray[indexPath.section] objectAtIndex:indexPath.row];
    // 创建cell
    MagazineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MagazineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    [cell setModel:model];
    return cell;
}
#pragma mark -- 点击cell --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    MagazineModel *model = [self.infosArray[indexPath.section] objectAtIndex:indexPath.row];
    MagazineWebController *webVc = [[MagazineWebController alloc] init];
    webVc.topic_url = model.topic_url;
    webVc.topic_name = model.topic_name;
    webVc.cover_img_new = model.cover_img_new;
    [self.navigationController pushViewController:webVc animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark -- 返回表头高度 --
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isAuthor || self.isClassify) {
        return 0;
    }
    if (section) {
        return 40;
    } else {
        return 0.1;
    }
}
#pragma mark -- 返回表尾的高度 --
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark -- 自定义表头 --
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    // headerView的重用方法需要注册
    MagezineHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    header.titleStr = [self.keysArray[section] substringFromIndex:5];
    return header;
}
#pragma mark -- cell出现的动画 --
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的显示动画为3D缩放
    
    //xy方向缩放的初始值为0.1
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:0.25 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

@end
