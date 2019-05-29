//
//  WCSearchBar.h
//  vci
//
//  Created by 齐江涛 on 2017/10/17.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCSearchBar;
@protocol WCSearchBarDelegate <NSObject>

- (void)searchBarDidCancel:(WCSearchBar *)searchBar;
- (void)searchBarDidEndSearch:(WCSearchBar *)searchBar;
- (void)searchBar:(WCSearchBar *)searchBar textDidChange:(NSString *)searchText;

@end

@interface WCSearchBar : UIView

@property (nonatomic, weak) id<WCSearchBarDelegate> delegate;
@property (nonatomic, copy) NSString *text;

- (void)giveUpFirstResponder;
- (void)obtainFirstResponder;

@end
