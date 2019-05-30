//
//  WCWordSheet.h
//  wc_comp_rj_bsd_wy_yl
//
//  Created by 齐江涛 on 2017/6/14.
//  Copyright © 2017年 Daydream. All rights reserved.
//

#import "WCSheet.h"
#import "VCFKFoundation.h"

UIKIT_EXTERN NSString *WCWordSheetTitleKey;
UIKIT_EXTERN NSString *WCWordSheetDetailKey;
UIKIT_EXTERN NSString *WCWordSheetSpeechKey;
UIKIT_EXTERN NSString *WCWordSheetIDKey;

@protocol WCWordSheetProxy <NSObject>

@optional
- (BOOL)wordSheet:(WCSheet *)sheet didClickIndex:(NSIndexPath *)indexPath info:(NSDictionary *)info;
- (void)wordSheetDidDismiss:(WCSheet *)sheet;

@end

@interface WCWordSheet : WCSheet

@property (nonatomic, weak) id<WCWordSheetProxy> proxy;
@property (nonatomic, strong, readonly) NSArray<NSDictionary *> *datas;

+ (instancetype)wordSheetWithModels:(NSArray<NSDictionary<NSString *, NSString *> *> *)datas;

@end
