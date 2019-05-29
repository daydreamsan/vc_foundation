//
//  VCFKViewController.m
//  vc_foundation
//
//  Created by daydreamsan on 05/28/2019.
//  Copyright (c) 2019 daydreamsan. All rights reserved.
//

#import "VCFKViewController.h"
#import "VCFKFoundation.h"
#import <WCMediaPlayer/QTMediaPlayer.h>

@interface VCFKViewController ()

@property (nonatomic, strong) QTMediaPlayer *player;

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [SVProgressHUD showSuccess:@"hello world"];
    
    QTMediaItem *item = [[QTMediaItem alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"15.mp3" ofType:nil];
    item.URL = [NSURL fileURLWithPath:path];
    self.player = [[QTMediaPlayer alloc] initWithPlayList:@[item]];
    [self.player play];
}

@end
