//
//  PriceListView.h
//  NhanHoa
//
//  Created by admin on 5/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ePriceVN,
    ePriceQT,
}TypeDomainPrice;

NS_ASSUME_NONNULL_BEGIN

@protocol PriceListViewDelegate
- (void)onCloseViewDomainPrice;
@end

@interface PriceListView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id<NSObject, PriceListViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *icClose;

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnDomainsVN;
@property (weak, nonatomic) IBOutlet UIButton *btnDomainsQT;

@property (weak, nonatomic) IBOutlet UITableView *tbDomains;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *icWaiting;

@property (nonatomic, strong) NSMutableArray *listQT;
@property (nonatomic, strong) NSMutableArray *listVN;
@property (nonatomic, assign) TypeDomainPrice eTypePrice;

- (IBAction)icCloseClicked:(UIButton *)sender;
- (IBAction)btnDomainsVNPress:(UIButton *)sender;
- (IBAction)btnDomainsQTPress:(UIButton *)sender;

- (void)setupUIForView;
- (void)showWaitingView: (BOOL)show;
- (void)prepareToDisplayData;

@end

NS_ASSUME_NONNULL_END
