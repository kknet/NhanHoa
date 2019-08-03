//
//  DomainDNSViewController.h
//  NhanHoa
//
//  Created by OS on 7/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainDNSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewNotSupport;
@property (weak, nonatomic) IBOutlet UILabel *lbInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnChange;


@property (weak, nonatomic) IBOutlet UILabel *lbNoData;
@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UITableView *tbRecords;

@property (nonatomic, strong) NSString *domainName;
@property (nonatomic, assign) BOOL supportDNSRecords;

- (IBAction)btnChangePress:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
