//
//  DNSRecordsViewController.h
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNSRecordsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewFooter;
@property (weak, nonatomic) IBOutlet UIButton *btnAddRecord;
@property (weak, nonatomic) IBOutlet UITableView *tbRecords;

@property (weak, nonatomic) IBOutlet UIView *viewNotSupport;
@property (weak, nonatomic) IBOutlet UILabel *lbInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnChange;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnAddRecordPress:(UIButton *)sender;
- (IBAction)btnChangePress:(UIButton *)sender;

@property (nonatomic, assign) BOOL supportDNSRecords;
@property (nonatomic, strong) NSString *domainName;

@end

NS_ASSUME_NONNULL_END
