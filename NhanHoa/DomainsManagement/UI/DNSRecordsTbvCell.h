//
//  DNSRecordsTbvCell.h
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNSRecordsTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrap;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbType;
@property (weak, nonatomic) IBOutlet UILabel *lbTypeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UILabel *lbValueValue;
@property (weak, nonatomic) IBOutlet UILabel *lbMX;
@property (weak, nonatomic) IBOutlet UILabel *lbMXValue;
@property (weak, nonatomic) IBOutlet UILabel *lbTTL;
@property (weak, nonatomic) IBOutlet UILabel *lbTTLValue;
@property (weak, nonatomic) IBOutlet UIButton *icDetail;

- (void)showDNSRecordContentWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
