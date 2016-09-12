//
//  LiveListViewController.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "LiveListViewController.h"
#import "NetworkTools.h"
#import "LiveListCell.h"
#import "LiveViewController.h"

#define SW [UIScreen mainScreen].bounds.size.width
#define SH [UIScreen mainScreen].bounds.size.height

static CGFloat const cellHeight = 430.f;

@interface LiveListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *listArray;

@end

@implementation LiveListViewController

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) style:UITableViewStylePlain];
        _tableView.rowHeight = cellHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = [NSArray array];
    }
    return _listArray;
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[LiveListCell class] forCellReuseIdentifier:@"LiveListCell"];
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    [[NetworkTools shareNetwordTools] getLiveListWithUId:@194366735 andInterest:@1 andLocation:@0 withLiveListBlock:^(NSArray *listArray) {
        weakSelf.listArray = listArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } withErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_listArray) {
        return _listArray.count;
    }
    return 0;
}

- (LiveListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveListCell *cell = (LiveListCell *)[tableView dequeueReusableCellWithIdentifier:@"LiveListCell"];
    if (!cell) {
        cell = [[LiveListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LiveListCell"];
    }
    LiveModel *live = _listArray[indexPath.row];
    cell.live = live;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveModel *live = _listArray[indexPath.row];
    LiveViewController *lvc = [[LiveViewController alloc] init];
    lvc.live = live;
    [self.navigationController showViewController:lvc sender:nil];
}

@end