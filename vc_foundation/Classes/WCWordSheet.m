//
//  WCWordSheet.m
//  wc_comp_rj_bsd_wy_yl
//
//  Created by 齐江涛 on 2017/6/14.
//  Copyright © 2017年 Daydream. All rights reserved.
//

#import "WCWordSheet.h"
#import "VCFKFoundation.h"

#define kWCWSEnFont(x)    [UIFont fontWithName:@"TimesNewRomanPSMT" size:(x)]
#define kWCWSCnFont(x)    [UIFont fontWithName:@"Heiti SC" size:(x)]

NSString *WCWordSheetTitleKey  = @"WCWordSheetTitleKey";
NSString *WCWordSheetDetailKey = @"WCWordSheetDetailKey";
NSString *WCWordSheetSpeechKey = @"WCWordSheetSpeechKey";
NSString *WCWordSheetIDKey     = @"WCWordSheetIDKey";

@interface WCWordSheetCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation WCWordSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [UILabel new];
        self.titleLabel.font = kWCWSEnFont(16);
        self.descLabel = [UILabel new];
        self.descLabel.font = kWCWSCnFont(12);
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descLabel];
        
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.descLabel.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

@interface WCWordSheet ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WCWordSheet
{
    NSArray *_datas;
}

- (instancetype)initWithContentView:(UIView *)contentView {
    if (self = [super initWithContentView:contentView]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor clearColor];
        [self.tableView registerClass:[WCWordSheetCell class] forCellReuseIdentifier:@"WCWordSheetCell"];
        self.tableView.rowHeight = 50.f;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        _keyView = self.tableView;
        [self.contentView addSubview:self.tableView];
    }
    return self;
}

+ (instancetype)wordSheetWithModels:(NSArray<NSDictionary<NSString *, NSString *> *> *)datas {
    WCWordSheet *sheet = [[WCWordSheet alloc] initWithContentView:nil];
    sheet->_datas = datas;
    return sheet;
}

- (void)showIn:(UIView *)view {
    [self.tableView reloadData];
    NSInteger limit = floor((kScreenHeight - 100.f - 50.f - 20.f) / 50.f);
    CGFloat height = self->_datas.count > limit ? limit * 50.f : self->_datas.count * 50.f;
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, height);
    [self.contentView sendSubviewToBack:self.tableView];
    self.tableView.bounces = self->_datas.count * 50.f > kScreenHeight - 50 - 20.f - 100.f;
    
    [super showIn:view];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self->_datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCWordSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WCWordSheetCell"];
    NSDictionary *dict = self->_datas[indexPath.row];
    NSString *title = [dict objectForKey:WCWordSheetTitleKey] ?: @"";
    title = [title stringByAppendingString:@"  "];
    NSString *part = [dict objectForKey:WCWordSheetSpeechKey] ?: @"";
    NSString *body = [dict objectForKey:WCWordSheetDetailKey] ?: @"";
    
    NSDictionary *normal0 = @{
                              NSFontAttributeName:kWCWSEnFont(18),
                              NSForegroundColorAttributeName:RGB_A(0X2b2b2b, 1.F)
                              };
    NSDictionary *normal = @{
                             NSFontAttributeName:kWCWSEnFont(18),
                             NSForegroundColorAttributeName:RGB_A(0Xa1a1a1, 1.F)
                             };
    NSDictionary *cnnormal = @{
                               NSFontAttributeName:kWCWSCnFont(12),
                               };
    NSMutableAttributedString *sA = [[NSMutableAttributedString alloc] initWithString:title attributes:normal0];
    NSMutableAttributedString *bA = [[NSMutableAttributedString alloc] initWithString:part attributes:normal];
    NSMutableAttributedString *cA = [[NSMutableAttributedString alloc] initWithString:body attributes:cnnormal];
    [sA appendAttributedString:bA];
    
    [cell.titleLabel setAttributedText:sA];
    [cell.descLabel setAttributedText:cA];
    
    [cell.titleLabel sizeToFit];
    [cell.descLabel sizeToFit];
    if (body.length) {
        cell.titleLabel.frame = CGRectMake(15, 5, kWCScreenWidth - 30, cell.titleLabel.height);
        cell.descLabel.frame = CGRectMake(15, cell.titleLabel.bottom + 2, kWCScreenWidth - 30, cell.descLabel.height);
    } else {
        cell.titleLabel.frame = CGRectMake(15, 0, kWCScreenWidth - 30, cell.titleLabel.height);
        cell.titleLabel.centerY = 25.f;
        cell.descLabel.frame = CGRectMake(15, cell.titleLabel.bottom + 2, kWCScreenWidth - 30, cell.descLabel.height);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.proxy && [self.proxy respondsToSelector:@selector(wordSheet:didClickIndex:info:)]) {
        BOOL dismiss = [self.proxy wordSheet:self didClickIndex:indexPath info:self->_datas[indexPath.row]];
        if (dismiss) {
            [self dismiss];
        }
    } else {
        [self dismiss];
        if ([self.proxy respondsToSelector:@selector(wordSheetDidDismiss:)]) {
            [self.proxy wordSheetDidDismiss:self];
        }
    }
}

#pragma mark - Overwrite
- (void)dismissWithCompletionHandler:(void (^)(void))handler {
    [super dismissWithCompletionHandler:handler];
    if (!handler) {
        if ([self.proxy respondsToSelector:@selector(wordSheetDidDismiss:)]) {
            [self.proxy wordSheetDidDismiss:self];
        }
    }
}

@end
