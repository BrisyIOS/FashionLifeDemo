//
//  ShowTarentoViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "ShowTarentoViewController.h"
#import "ShowTarentoTableViewCell.h"
#import "ShowTarentoModel.h"
#import "CommonActivityIndicatorView.h"

@interface ShowTarentoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) CommonActivityIndicatorView *activityView;

@property (nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)ShowTarentoModel *model;

@property(nonatomic ,strong)NSString *UrlString;

@end

@implementation ShowTarentoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"商品详情";
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    [self.tableView registerClass:[ShowTarentoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    
    self.activityView = [[CommonActivityIndicatorView alloc] init];
    [self.view addSubview:_activityView];
    
    if (_detailModel.goods_id.length == 0) {
        self.UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/goods?app_key=Android&build=2015112301&goods_id=%@&v=1.0", _modelString];
    }else
    {
        self.UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/goods?app_key=Android&build=2015112301&goods_id=%@&v=1.0", _detailModel.goods_id];
    }
    



    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:_UrlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data == nil) {
            return ;
        }
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSMutableDictionary *dataDic = dic[@"data"];
        self.model = [[ShowTarentoModel alloc]init];
        
        [self.model setValuesForKeysWithDictionary:dataDic];
   
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.activityView endCommonActivity];
        });
    }] resume];
    
    
    
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
 
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowTarentoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.number = _model.images_item.count;
    cell.showModel = _model;
    cell.selectionStyle = NO;
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShowTarentoTableViewCell heightForCell:_model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
