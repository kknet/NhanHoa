//
//  DNSRecordManagerView.h
//  NhanHoa
//
//  Created by OS on 8/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum DNSRecordType{
    DNSRecordAddNew,
    DNSRecordUpdate,
}DNSRecordType;

NS_ASSUME_NONNULL_BEGIN

@protocol DNSRecordManagerViewDelegate
- (void)closeAddDNSRecordView;
- (void)reloadDNSRecordListAfterAndOrEdit;
@end


@interface DNSRecordManagerView : UIView<UITextFieldDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate>

@property (nonatomic, strong) id<NSObject, DNSRecordManagerViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icClose;

@property (weak, nonatomic) IBOutlet UILabel *lbTop;
@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UILabel *lbType;
@property (weak, nonatomic) IBOutlet UITextField *tfType;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
@property (weak, nonatomic) IBOutlet UIButton *btnType;
@property (weak, nonatomic) IBOutlet UILabel *lbMX;
@property (weak, nonatomic) IBOutlet UITextField *tfMX;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UITextField *tfValue;
@property (weak, nonatomic) IBOutlet UILabel *lbTTL;
@property (weak, nonatomic) IBOutlet UITextField *tfTTL;
@property (weak, nonatomic) IBOutlet UIButton *btnAddRecord;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UILabel *lbWarning;

- (IBAction)btnAddRecordPress:(UIButton *)sender;
- (IBAction)btnTypePress:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;
- (IBAction)btnResetPress:(UIButton *)sender;

@property (nonatomic, strong) NSString *domain;
@property (nonatomic, assign) float margin;
@property (nonatomic, strong) UITableView *tbType;
@property (nonatomic, strong) NSArray *listType;
@property (nonatomic, assign) DNSRecordType curType;
@property (nonatomic, strong) NSDictionary *curInfo;

- (void)setupUIForViewWithType: (DNSRecordType)type;
- (void)showContentForView;

- (void)showDNSRecordContentWithInfo: (NSDictionary *)info;
- (void)resetAllValue;
- (void)reUpdateLayoutForView;

@end

NS_ASSUME_NONNULL_END
