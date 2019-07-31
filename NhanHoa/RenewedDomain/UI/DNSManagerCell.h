//
//  DNSManagerCell.h
//  NhanHoa
//
//  Created by OS on 7/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNSManagerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbHost;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa1;
@property (weak, nonatomic) IBOutlet UILabel *lbType;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa2;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa3;
@property (weak, nonatomic) IBOutlet UILabel *lbMX;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa4;
@property (weak, nonatomic) IBOutlet UILabel *lbTTL;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa5;
@property (weak, nonatomic) IBOutlet UIButton *icMore;

@end

NS_ASSUME_NONNULL_END
