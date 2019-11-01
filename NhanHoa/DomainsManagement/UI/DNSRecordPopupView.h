//
//  DNSRecordPopupView.h
//  NhanHoa
//
//  Created by OS on 11/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DNSRecordPopupViewDelegate <NSObject>
@optional
- (void)onButtonEditDNSRecordPressWithRecordId: (NSString *)recordId;
- (void)onButtonDeleteDNSRecordPressWithRecordId: (NSString *)recordId;
@end

@interface DNSRecordPopupView : UIView

@property (nonatomic, strong) id<DNSRecordPopupViewDelegate, NSObject> delegate;
@property (nonatomic, strong) NSString *recordId;

@property (nonatomic, strong) UIView *viewTop;
@property (nonatomic, strong) UILabel *lbRecordName;
@property (nonatomic, strong) UILabel *lbRecordNameValue;

@property (nonatomic, strong) UILabel *lbRecordType;
@property (nonatomic, strong) UILabel *lbRecordTypeValue;

@property (nonatomic, strong) UILabel *lbRecordValue;
@property (nonatomic, strong) UILabel *lbRecordValueValue;

@property (nonatomic, strong) UILabel *lbMX;
@property (nonatomic, strong) UILabel *lbMXValue;

@property (nonatomic, strong) UILabel *lbTTL;
@property (nonatomic, strong) UILabel *lbTTLValue;

@property (nonatomic, strong) UIButton *icClose;

@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) UIButton *btnEdit;
@property (nonatomic, strong) UIButton *btnDelete;


- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (void)fadeOut;
- (void)displayRecordContentWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
