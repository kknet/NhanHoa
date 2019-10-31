//
//  AddDNSRecordsView.h
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddDNSRecordsView : UIView

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UILabel *lbTop;
@property (weak, nonatomic) IBOutlet UILabel *lbRecordName;
@property (weak, nonatomic) IBOutlet UITextField *tfRecordName;
@property (weak, nonatomic) IBOutlet UILabel *lbRecordType;
@property (weak, nonatomic) IBOutlet UITextField *tfRecordType;
@property (weak, nonatomic) IBOutlet UIImageView *imgRecordType;
@property (weak, nonatomic) IBOutlet UIButton *btnRecordType;
@property (weak, nonatomic) IBOutlet UILabel *lbMX;
@property (weak, nonatomic) IBOutlet UITextField *tfMX;
@property (weak, nonatomic) IBOutlet UILabel *lbRecordValue;
@property (weak, nonatomic) IBOutlet UITextField *tfRecordValue;
@property (weak, nonatomic) IBOutlet UILabel *lbTTLValue;
@property (weak, nonatomic) IBOutlet UITextField *tfTTLValue;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveRecords;
@property (weak, nonatomic) IBOutlet UILabel *lbDesc;

- (IBAction)icCloseClick:(UIButton *)sender;
- (IBAction)btnRecordTypePress:(UIButton *)sender;
- (IBAction)btnResetPress:(UIButton *)sender;
- (IBAction)btnSaveRecordsPress:(UIButton *)sender;

- (void)setupUIForViewWithHeighNav: (float)hNav;

@end

NS_ASSUME_NONNULL_END
