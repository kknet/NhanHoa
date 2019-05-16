//
//  PriceListView.h
//  NhanHoa
//
//  Created by admin on 5/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PriceListViewDelegate
- (void)onCloseViewDomainPrice;
@end

@interface PriceListView : UIView

@property (nonatomic, strong) id<NSObject, PriceListViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *icClose;

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnAllDomains;
@property (weak, nonatomic) IBOutlet UIButton *btnExpireDomains;
@property (weak, nonatomic) IBOutlet UITableView *tbDomains;

- (IBAction)icCloseClicked:(UIButton *)sender;
- (IBAction)btnAllDomainsPress:(UIButton *)sender;
- (IBAction)btnExpireDomainsPress:(UIButton *)sender;

- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
