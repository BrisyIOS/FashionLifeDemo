//
//  ShareCommentViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "ShareCommentViewController.h"
#import "ShowTarentoModel.h"
#import "ShowCommentModel.h"
#import "ShowCommentTableViewCell.h"
#import "ShowCountsModel.h"
#import "ShowHeader.h"
#import "Header.h"
#import "MJRefresh.h"
#import "DIYLikeButton.h"
#import "UMSocial.h"

@interface ShareCommentViewController ()<UITableViewDataSource, UITableViewDelegate, UMSocialDataDelegate, UMSocialUIDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *modelArray;

@property (nonatomic, strong)ShowTarentoModel *showModel;

@property (nonatomic, strong)ShowCountsModel *countsModel;

@property (nonatomic, strong)NSString *UrlString;

@end

int numberComment = 1;

@implementation ShareCommentViewController

- (void)dealloc
{
    numberComment = 1;
}


- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"时尚生活";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-fenxiang-3"] style:UIBarButtonItemStyleDone target:self action:@selector(rightShareBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    [self.tableView registerClass:[ShowCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
 
    [self.tableView registerClass:[ShowHeader class] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.view addSubview:_tableView];
 
    
    self.UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/goods?app_key=Android&build=2015110402&goods_id=%@&v=1.0", _detailModel.goods_id];
    
    NSString *UrlStringComment = [NSString stringWithFormat:@"http://app.iliangcang.com/goods/commentsnew?app_key=Android&build=2015112301&count=3&goods_id=%@&page=1&v=1.0", _detailModel.goods_id];
    
    
    [self getSessionDataTaskWithURLString:UrlStringComment];

   
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:_UrlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data == nil) {
            return ;
        }
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSMutableDictionary *dataDic = dic[@"data"];
        self.showModel = [[ShowTarentoModel alloc]init];
        
        [self.showModel setValuesForKeysWithDictionary:dataDic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }] resume];
    
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerAction)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerAction)];
    
    
}

- (void)headerAction
{
   
    numberComment = 1;
    
    _modelArray = nil;
    NSString *UrlStringComment = [NSString stringWithFormat:@"http://app.iliangcang.com/goods/commentsnew?app_key=Android&build=2015112301&count=3&goods_id=%@&page=%d&v=1.0", _detailModel.goods_id, numberComment];

  

    [self getSessionDataTaskWithURLString:UrlStringComment];
    
    
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
}
- (void)footerAction
{
    
    numberComment++;
    
    NSString *UrlStringComment = [NSString stringWithFormat:@"http://app.iliangcang.com/goods/commentsnew?app_key=Android&build=2015112301&count=3&goods_id=%@&page=%d&v=1.0", _detailModel.goods_id, numberComment];
    [self getSessionDataTaskWithURLString:UrlStringComment];
    [self.tableView.footer endRefreshing];
}

- (void)rightShareBarButtonAction:(UIBarButtonItem *)button
{
    NSLog(@"分享");
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    UIImage *imge = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.detailModel.goods_image]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5658406467e58ebfc9002494"
                                      shareText:[NSString stringWithFormat:@"%@ %@", self.detailModel.goods_name, _UrlString]
                                     shareImage:imge
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToDouban, nil]
                                       delegate:self];

}

- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
    }
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadSuperView" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.commentModel = _modelArray[indexPath.row];
   
    cell.selectionStyle = NO;
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < _modelArray.count; i++) {
        if (indexPath.row == i) {
            return [ShowCommentTableViewCell setHeightCell:_modelArray[i]];
        }
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [ShowHeader heightForCell:_showModel];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShowHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    headerView.number = _showModel.images_item.count;
    headerView.showModel = _showModel;
    headerView.detailModel = _detailModel;
    return headerView;
}


- (void)getSessionDataTaskWithURLString:(NSString *)string
{
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:string] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data == nil) {
            return ;
        }
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableDictionary *dataDic = dic[@"data"];
        
        
        self.countsModel = [[ShowCountsModel alloc]init];
        
        [self.countsModel setValuesForKeysWithDictionary:dataDic];
    
        if (self.countsModel.num_items != 0) {
            
          
            for (NSMutableDictionary *itemsDic in dataDic[@"items"]) {
                
                ShowCommentModel *model = [[ShowCommentModel alloc]init];
                
                [model setValuesForKeysWithDictionary:itemsDic];
                [self.modelArray addObject:model];
            }
       
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
      
            });

            
        }
  
        
        
    }] resume];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
