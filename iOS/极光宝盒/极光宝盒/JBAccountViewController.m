//
//  JBAccountViewController.m
//  极光宝盒
//
//  Created by wuxingchen on 16/7/20.
//  Copyright © 2016年 57380422@qq.com. All rights reserved.
//

#import "JBAccountViewController.h"
#import "JBChannelTableViewCell.h"
#import "JBAppsTableViewController.h"
#import "JBScanViewController.h"

@interface JBAccountViewController ()<UITableViewDelegate, UITableViewDataSource>
- (IBAction)scan_button:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *channel_tableView;

@end

@implementation JBAccountViewController

#pragma mark - default
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JBChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"JBChannelTableViewCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

#pragma mark - scan
- (IBAction)scan_button:(id)sender {
    JBScanViewController *controller = [[JBScanViewController alloc] init];
    //支付宝style
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    if ([UIScreen mainScreen].bounds.size.height <= 480 )
    {
        //3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    style.alpa_notRecoginitonArea = 0.6;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    style.animationImage = imgFullNet;

    controller.style = style;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JBAppsTableViewController *appsVC = [[JBAppsTableViewController alloc] init];
    JBChannelTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    appsVC.navigationItem.title = cell.title_label.text;
    [self.navigationController pushViewController:appsVC animated:YES];
}



@end
