//
//  XXCeshiViewController.m
//  SAStackView_Example
//
//  Created by 王士昌 on 2018/7/24.
//  Copyright © 2018年 shichang.wang. All rights reserved.
//

#import "XXCeshiViewController.h"
#import <Masonry/Masonry.h>

@interface XXCeshiViewController ()

@end

@implementation XXCeshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加进去不同的UI视图";
    self.stackView.backgroundColor = [UIColor yellowColor];
}


- (UIView *)createOtherView {

    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sa_temp_img"]];
    img.contentMode = UIViewContentModeScaleAspectFit;

    return img;
}



@end
