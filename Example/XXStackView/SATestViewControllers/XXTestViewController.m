//
//  XXTestViewController.m
//  SAStackView_Example
//
//  Created by 王士昌 on 2018/7/24.
//  Copyright © 2018年 shichang.wang. All rights reserved.
//

#import "XXTestViewController.h"
#import <Masonry/Masonry.h>

@interface XXTestViewController ()

@property (nonatomic, strong) UILabel *axisLabel;

@property (nonatomic, strong) UILabel *alignmentLabel;

@property (nonatomic, strong) UILabel *distributionLabel;



@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UIButton *deleteBtn;



@property (nonatomic, strong) UIButton *changeHVButton;

@property (nonatomic, strong) UIButton *changeAlignmentBtn;

@property (nonatomic, strong) UIButton *changeDistributionBtn;

@end

@implementation XXTestViewController

#pragma mark -
#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviewsContraints];
}

#pragma mark -
#pragma mark - Event response

- (void)pressAddButtonAction:(UIButton *)btn {
    if (self.stackView.arrangedSubviews.count > 10) return;
    UIView *view = [self createOtherView];
    [self.stackView insertArrangedSubview:view atIndex:0];
    [self.stackView addArrangedSubview:view];
}

- (void)pressDeleteButtonAction:(UIButton *)btn {
    if (!self.stackView.arrangedSubviews.count) return;
    UIView *tempView = self.stackView.arrangedSubviews.lastObject;
#warning 注意这里不可以直接 removeArrangedSubview：self.stackView.arrangedSubviews.lastObject！！！
    [self.stackView removeArrangedSubview:tempView];
#warning 注意stackView removeArrangedSubview：之后stackView还是会持有tempView的 所以要在这里removeFromSuperView或hidden掉！！！
    [tempView removeFromSuperview];
}

- (void)pressChangeButtonAction:(UIButton *)btn {
    NSMutableString *tip = [[NSMutableString alloc]initWithString:@"布局方向类型："];
    if (self.stackView.axis == UILayoutConstraintAxisVertical) {
        self.stackView.axis = UILayoutConstraintAxisHorizontal;
        [tip appendString:@"UILayoutConstraintAxisHorizontal"];
    }else {
        self.stackView.axis = UILayoutConstraintAxisVertical;
        [tip appendString:@"UILayoutConstraintAxisVertical"];
    }
    self.axisLabel.text = tip;
}

- (void)pressChangeAlignmentButtonAction:(UIButton *)btn {
    NSMutableString *tip = [[NSMutableString alloc]initWithString:@"对齐类型："];
    if (self.stackView.alignment == UIStackViewAlignmentFill) {
        self.stackView.alignment = UIStackViewAlignmentLeading;
        [tip appendString:@"UIStackViewAlignmentLeading"];
    }else if (self.stackView.alignment== UIStackViewAlignmentLeading) {
        self.stackView.alignment = UIStackViewAlignmentFirstBaseline;
        [tip appendString:@"UIStackViewAlignmentFirstBaseline"];
    }else if (self.stackView.alignment == UIStackViewAlignmentFirstBaseline) {
        self.stackView.alignment = UIStackViewAlignmentCenter;
        [tip appendString:@"UIStackViewAlignmentCenter"];
    }else if (self.stackView.alignment == UIStackViewAlignmentCenter) {
        self.stackView.alignment = UIStackViewAlignmentTrailing;
        [tip appendString:@"UIStackViewAlignmentTrailing"];
    }else if (self.stackView.alignment == UIStackViewAlignmentTrailing) {
        self.stackView.alignment = UIStackViewAlignmentLastBaseline;
        [tip appendString:@"UIStackViewAlignmentLastBaseline"];
    }else if (self.stackView.alignment == UIStackViewAlignmentLastBaseline) {
        self.stackView.alignment = UIStackViewAlignmentFill;
        [tip appendString:@"UIStackViewAlignmentFill"];
    }
    self.alignmentLabel.text = tip;
}

- (void)pressChangeDistributionButtonAction:(UIButton *)btn {
    NSMutableString *tip = [[NSMutableString alloc]initWithString:@"视图分布类型："];
    if (self.stackView.distribution == UIStackViewDistributionFillEqually) {
        self.stackView.distribution = UIStackViewDistributionFillProportionally;
        [tip appendString:@"UIStackViewDistributionFillProportionally"];
    }else if (self.stackView.distribution == UIStackViewDistributionFillProportionally) {
        self.stackView.distribution = UIStackViewDistributionEqualSpacing;
        [tip appendString:@"UIStackViewDistributionEqualSpacing"];
    }else if (self.stackView.distribution == UIStackViewDistributionEqualSpacing) {
        self.stackView.distribution = UIStackViewDistributionEqualCentering;
        [tip appendString:@"UIStackViewDistributionEqualCentering"];
    }else if (self.stackView.distribution == UIStackViewDistributionEqualCentering) {
        self.stackView.distribution = UIStackViewDistributionFill;
        [tip appendString:@"UIStackViewDistributionFill"];
    }else if (self.stackView.distribution == UIStackViewDistributionFill) {
        self.stackView.distribution = UIStackViewDistributionFillEqually;
        [tip appendString:@"UIStackViewDistributionFillEqually"];
    }
    self.distributionLabel.text = tip;
}

#pragma mark -
#pragma mark - Private Methods

- (UIView *)createViews {
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.f green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    lab.text = @"sssssipadga";
    lab.numberOfLines = 0;
    return lab;
}

- (UIView *)createOtherView {
    
    return [self createViews];
}

#pragma mark -
#pragma mark - Getters && Setters

- (UILabel *)axisLabel {
    if (!_axisLabel) {
        _axisLabel = [[UILabel alloc]init];
        _axisLabel.numberOfLines = 0;
        _axisLabel.textAlignment = NSTextAlignmentCenter;
        _axisLabel.backgroundColor = [UIColor orangeColor];
        _axisLabel.text = @"布局方向类型：UILayoutConstraintAxisHorizontal";
    }
    return _axisLabel;
}

- (UILabel *)alignmentLabel {
    if (!_alignmentLabel) {
        _alignmentLabel = [[UILabel alloc]init];
        _alignmentLabel.numberOfLines = 0;
        _alignmentLabel.textAlignment = NSTextAlignmentCenter;
        _alignmentLabel.backgroundColor = [UIColor cyanColor];
        _alignmentLabel.text = @"对齐类型：UIStackViewAlignmentFill";
    }
    return _alignmentLabel;
}

- (UILabel *)distributionLabel {
    if (!_distributionLabel) {
        _distributionLabel = [[UILabel alloc]init];
        _distributionLabel.numberOfLines = 0;
        _distributionLabel.textAlignment = NSTextAlignmentCenter;
        _distributionLabel.backgroundColor = [UIColor magentaColor];
        _distributionLabel.text = @"视图分布类型：UIStackViewDistributionFillEqually";
    }
    return _distributionLabel;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        NSMutableArray <UIView *>*views = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            [views addObject:[self createViews]];
        }
        _stackView = [[UIStackView alloc]initWithArrangedSubviews:views];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.spacing = 10.f;
    }
    return _stackView;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"add" forState:UIControlStateNormal];
        [_addButton setBackgroundColor:[UIColor greenColor]];
        [_addButton addTarget:self action:@selector(pressAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"delete" forState:UIControlStateNormal];
        [_deleteBtn setBackgroundColor:[UIColor redColor]];
        [_deleteBtn addTarget:self action:@selector(pressDeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIButton *)changeHVButton {
    if (!_changeHVButton) {
        _changeHVButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeHVButton setTitle:@"change HV" forState:UIControlStateNormal];
        [_changeHVButton setBackgroundColor:[UIColor orangeColor]];
        
        [_changeHVButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changeHVButton addTarget:self action:@selector(pressChangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeHVButton;
}

- (UIButton *)changeAlignmentBtn {
    if (!_changeAlignmentBtn) {
        _changeAlignmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeAlignmentBtn setTitle:@"change alignment" forState:UIControlStateNormal];
        [_changeAlignmentBtn setBackgroundColor:[UIColor cyanColor]];
        _changeAlignmentBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_changeAlignmentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changeAlignmentBtn addTarget:self action:@selector(pressChangeAlignmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeAlignmentBtn;
}

- (UIButton *)changeDistributionBtn {
    if (!_changeDistributionBtn) {
        _changeDistributionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeDistributionBtn setTitle:@"change distribution" forState:UIControlStateNormal];
        [_changeDistributionBtn setBackgroundColor:[UIColor magentaColor]];
        _changeDistributionBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_changeDistributionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changeDistributionBtn addTarget:self action:@selector(pressChangeDistributionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeDistributionBtn;
}

#pragma mark -
#pragma mark - SetupConstraints

- (void)setupSubviewsContraints {
    [self.view addSubview:self.axisLabel];
    [self.view addSubview:self.alignmentLabel];
    [self.view addSubview:self.distributionLabel];
    [self.view addSubview:self.stackView];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.deleteBtn];
    [self.view addSubview:self.changeHVButton];
    [self.view addSubview:self.changeAlignmentBtn];
    [self.view addSubview:self.changeDistributionBtn];
    
    [self.axisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
    
    [self.alignmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.equalTo(self.axisLabel.mas_bottom);
    }];
    
    [self.distributionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.equalTo(self.alignmentLabel.mas_bottom);
    }];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.bounds), 200));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stackView.mas_bottom).offset(20);
        make.leading.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stackView.mas_bottom).offset(20);
        make.trailing.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.changeHVButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.addButton.mas_leading);
        make.top.equalTo(self.addButton.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.changeAlignmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.deleteBtn.mas_trailing);
        make.top.equalTo(self.deleteBtn.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.changeDistributionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(120, 50));
    }];
}





@end
