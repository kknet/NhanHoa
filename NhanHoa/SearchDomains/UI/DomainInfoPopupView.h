//
//  DomainInfoPopupView.h
//  NhanHoa
//
//  Created by OS on 11/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainInfoPopupView : UIView<WebServiceUtilsDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *lbHeader;
@property (nonatomic, strong) UIButton *icClose;
@property (nonatomic, strong) UITableView *tbInfo;
@property (nonatomic, strong) UIActivityIndicatorView *icWaiting;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hCell;
@property (nonatomic, assign) float leftMaxSize;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSDictionary *domainInfo;
@property (nonatomic, strong) UIFont *fontForGetHeight;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (void)fadeOut;

@end

NS_ASSUME_NONNULL_END
