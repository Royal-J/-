//
//  BDJTableViewController.m
//  baisibudejie
//
//  Created by HJY on 2016/11/21.
//  Copyright © 2016年 HJY. All rights reserved.
//

#import "BDJTableViewController.h"
#import "BDJEssenceModel.h"
#import "EssenceVideoCell.h"

@interface BDJTableViewController ()<UITableViewDelegate, UITableViewDataSource>

//表格
@property (nonatomic, strong)UITableView *tbView;
//数据
@property (nonatomic, strong)BDJEssenceModel *model;

//上下拉刷新分页
@property (nonatomic, strong)NSNumber *np;

@end

@implementation BDJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    
    self.np = @(0);
    [self downloadListData];
    
}

//创建表格
- (void)createTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tbView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self.view addSubview:self.tbView];
    
    //约束
    __weak typeof(self) weakSelf = self;
    [self.tbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    
    //上下拉刷新
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstPage)];
    
    self.tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNextPage)];
}

- (void)loadFirstPage {
    self.np = @(0);
    [self downloadListData];
}

- (void)loadNextPage {
    self.np = self.model.info.np;
    [self downloadListData];
}

//下载列表数据
- (void)downloadListData {
    //http://s.budejie.com/topic/list/jingxuan/41/bs0315-iphone-4.3/0-20.json
    
    //开始下载
    [ProgressHUD show:@"正在下载" Interaction: NO];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@/bs0315-iphone-4.3/%@-20.json", self.url,self.np];
    
    [BDJDownloader downloadWithURLString:urlString success:^(NSData *data) {
        BDJEssenceModel *model = [[BDJEssenceModel alloc] initWithData:data error:nil];
        //        NSLog(@"=====");
        
        
        if (self.np.integerValue == 0) {
            //第一页
            self.model = model;
        }else{
            //后面的页数
            NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.model.list];
            
            [tmpArray addObjectsFromArray:model.list];
            model.list = (NSArray<Optional, BDJEssenceDetail> *)tmpArray;
            
            self.model = model;
        }
        
        
        //刷新表格
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView reloadData];
            
            //结束第三方库的刷新
            [self.tbView.mj_header endRefreshing];
            [self.tbView.mj_footer endRefreshing];
            
            [ProgressHUD showSuccess:@"下载成功"];
        });
        
        
        /**
         若上面出现错误，可定义一个NSError对象，打印错误信息
         NSError *error = nil;
         BDJEssenceModel *model = [[BDJEssenceModel alloc] initWithData:data error:&error];
         if (error) {
         NSLog(@"%@", error);
         }else{
         
         self.model = model;
         
         //刷新表格
         dispatch_async(dispatch_get_main_queue(), ^{
         [self.tbView reloadData];
         });
         }
         */
        
    } fail:^(NSError *error) {
        [ProgressHUD showError:@"下载失败"];
    }];
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

#pragma mark - UITableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BDJEssenceDetail *detail = self.model.list[indexPath.row];
    
    UITableViewCell *cell = nil;
    if ([detail.type isEqualToString:@"video"]) {
        //视频的cell
        cell = [EssenceVideoCell videoCellForTableView:tableView atIndexPath:indexPath withModel:detail];
    }else{
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceDetail *detail = self.model.list[indexPath.row];
    return detail.cellHeight.floatValue;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 500;
}


@end
