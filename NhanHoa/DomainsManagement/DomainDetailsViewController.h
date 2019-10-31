//
//  DomainDetailsViewController.h
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UIButton *btnRenewal;
@property (weak, nonatomic) IBOutlet UIButton *btnSignature;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdatePassport;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeNameServer;
@property (weak, nonatomic) IBOutlet UIButton *btnDNSRecordsManagement;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnRenewalPress:(UIButton *)sender;
- (IBAction)btnSignaturePress:(UIButton *)sender;
- (IBAction)btnUpdatePassportPress:(UIButton *)sender;
- (IBAction)btnChangeNameServerPress:(UIButton *)sender;
- (IBAction)btnDNSRecordsManagement:(UIButton *)sender;

@property (nonatomic, strong) NSString *ordId;
@property (nonatomic, strong) NSString *cusId;

@end

NS_ASSUME_NONNULL_END
