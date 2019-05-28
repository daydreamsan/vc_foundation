//
//  VCFKViewController.m
//  vc_foundation
//
//  Created by daydreamsan on 05/28/2019.
//  Copyright (c) 2019 daydreamsan. All rights reserved.
//

#import "VCFKViewController.h"
#import "VCFKFoundation.h"

@interface VCFKViewController ()

@end

@implementation VCFKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton defaultButtonWithTitle:@"这是一个气愤的button"];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
