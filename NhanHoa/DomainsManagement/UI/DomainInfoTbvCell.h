//
//  DomainInfoTbvCell.h
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainInfoTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrap;
@property (weak, nonatomic) IBOutlet UILabel *lbID;
@property (weak, nonatomic) IBOutlet UILabel *lbIDValue;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbExpireDate;
@property (weak, nonatomic) IBOutlet UILabel *lbExpireDateValue;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbStatusValue;

- (void)showContentWithDomainInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
