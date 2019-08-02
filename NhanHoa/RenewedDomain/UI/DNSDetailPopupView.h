//
//  DNSDetailPopupView.h
//  NhanHoa
//
//  Created by OS on 8/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DNSDetailPopupViewDelegate
- (void)editDNSRecordOnPopupViewWithTag: (int)tag;
- (void)deleteDNSRecordOnPopupViewWithTag: (int)tag;
- (void)closeDNSRecordOnPopupView;
@end


@interface DNSDetailPopupView : UIView

- (id)initWithFrame:(CGRect)frame hasMXValue: (BOOL)hasMX;

@property (nonatomic, strong) id<NSObject, DNSDetailPopupViewDelegate> delegate;

@property (strong, nonatomic) UIView *viewHeader;
@property (strong, nonatomic) UILabel *lbHeader;
@property (strong, nonatomic) UIButton *icClose;

@property (strong, nonatomic) UILabel *lbName;
@property (strong, nonatomic) UITextField *tfName;
@property (strong, nonatomic) UILabel *lbType;
@property (strong, nonatomic) UITextField *tfType;
@property (strong, nonatomic) UILabel *lbMX;
@property (strong, nonatomic) UITextField *tfMX;
@property (strong, nonatomic) UILabel *lbValue;
@property (strong, nonatomic) UITextField *tfValue;
@property (strong, nonatomic) UILabel *lbTTL;
@property (strong, nonatomic) UITextField *tfTTL;
@property (strong, nonatomic) UIButton *btnEdit;
@property (strong, nonatomic) UIButton *btnDelete;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (void)fadeOut;
- (void)showDNSRecordInfoWithContent: (NSDictionary *)info;
- (void)closePopupView;

@end

NS_ASSUME_NONNULL_END
