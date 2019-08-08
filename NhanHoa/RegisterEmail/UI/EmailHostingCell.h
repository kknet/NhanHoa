//
//  EmailHostingCell.h
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmailHostingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrapper;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbMemory;
@property (weak, nonatomic) IBOutlet UILabel *lbMemoryValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa1;

@property (weak, nonatomic) IBOutlet UILabel *lbEmailPOP3;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailPOP3Value;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa2;

@property (weak, nonatomic) IBOutlet UILabel *lbEmailForwarders;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailForwardersValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa3;

@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa4;

@property (weak, nonatomic) IBOutlet UIButton *btnAddCart;

@end

NS_ASSUME_NONNULL_END
