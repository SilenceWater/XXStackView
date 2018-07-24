//
//  XXViewController.m
//  XXStackView
//
//  Created by shichang.wang on 07/24/2018.
//  Copyright (c) 2018 shichang.wang. All rights reserved.
//

#import "XXViewController.h"
#import <Masonry/Masonry.h>

static NSString *const kCellIdentifier = @"com.sa.stackView.demo.cell.identifier";
@interface XXViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation XXViewController

#pragma mark -
#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"stackView test";
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setupSubviewsContraints];
}

#pragma mark -
#pragma mark - UITableView delegate && data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"开发ing";
        default:
            return @"可使用";
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    NSDictionary *dict = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"titleName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.dataArr[indexPath.section][indexPath.row];
    NSString *str =  dict[@"className"];
    UIViewController *controller = nil;
    controller = [[NSClassFromString(str) alloc] init];
    controller.title = dict[@"titleName"];
    [controller setHidesBottomBarWhenPushed:YES];
    controller.view.backgroundColor = [UIColor blackColor];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark - Event response

#pragma mark -
#pragma mark - Private Methods

#pragma mark -
#pragma mark - Getters && Setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"classdata" ofType:@"plist"];
        _dataArr = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArr;
}

#pragma mark -
#pragma mark - SetupConstraints

- (void)setupSubviewsContraints {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


@end
