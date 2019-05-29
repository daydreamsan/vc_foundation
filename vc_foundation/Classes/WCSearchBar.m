//
//  WCSearchBar.m
//  vci
//
//  Created by 齐江涛 on 2017/10/17.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "WCSearchBar.h"
#import "WCTextField.h"
#import "VCFKFoundation.h"

#define kWCSLeftMargin  8.f
#define kWCSRightMargin 8.f
#define kWCSBottomMargin    8.f

@interface WCSearchBar ()<UITextFieldDelegate>

@property (nonatomic, strong) WCTextField *searchTextField;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation WCSearchBar

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.searchTextField = [[WCTextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    self.searchTextField.tintColor = kMainTintColor;
    self.searchTextField.font = kPingFangSCRegularFontOfSize(14);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveTextFieldChangeTextNotification:) name:UITextFieldTextDidChangeNotification object:self.searchTextField];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(kScreenWidth, 40)];
    image = [image imageByRoundCornerRadius:(4.f) borderWidth:1.f/kScreenScale borderColor:RGB_A(0xe0e0e0, 1.f)];
    [self.searchTextField setBackground:image];
    self.searchTextField.placeholder = @"在此输入要搜索的单词或汉字";
    [self addSubview:self.searchTextField];
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:kMainTintColor forState:UIControlStateNormal];
    self.cancelButton.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 0);
    [self.cancelButton sizeToFit];
    @weakify(self)
    [self.cancelButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        @strongify(self)
        [self.searchTextField resignFirstResponder];
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarDidCancel:)]) {
            [self.delegate searchBarDidCancel:self];
        }
    }];
    
    [self addSubview:self.cancelButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.searchTextField.left = kWCSLeftMargin;
    self.searchTextField.bottom = self.height - kWCSBottomMargin;
    self.searchTextField.width = self.width - self.cancelButton.width - kWCSRightMargin - kWCSLeftMargin;
    self.cancelButton.right = self.width - kWCSRightMargin;
    self.cancelButton.centerY = self.searchTextField.centerY;
}

#pragma mark - Noti
- (void)didReceiveTextFieldChangeTextNotification:(NSNotification *)noti {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate searchBar:self textDidChange:self.searchTextField.text];
        });
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarDidEndSearch:)]) {
        [self.delegate searchBarDidEndSearch:self];
    }
    return YES;
}

#pragma mark - API
- (NSString *)text {
    return self.searchTextField.text;
}

- (void)giveUpFirstResponder {
    [self.searchTextField resignFirstResponder];
}
- (void)obtainFirstResponder {
    [self.searchTextField becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    [super canBecomeFirstResponder];
    return YES;
}

- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    return [self.searchTextField becomeFirstResponder];
}

- (BOOL)canResignFirstResponder {
    [super canResignFirstResponder];
    return YES;
}
- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    [self.searchTextField resignFirstResponder];
    return YES;
}

@end
