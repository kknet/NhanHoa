//
//  EmailServerCell.h
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmailServerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrapper;
@property (weak, nonatomic) IBOutlet UILabel *lbHeaderBG;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UITextField *tfTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgArr;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseTime;

@property (weak, nonatomic) IBOutlet UIImageView *imgEmailInbox;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailInbox;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailInboxValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa1;

@property (weak, nonatomic) IBOutlet UIImageView *imgStore;
@property (weak, nonatomic) IBOutlet UILabel *lbStore;
@property (weak, nonatomic) IBOutlet UILabel *lbStoreValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa2;

@property (weak, nonatomic) IBOutlet UIImageView *imgEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa3;

@property (weak, nonatomic) IBOutlet UIImageView *imgEmailForwarders;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailForwarders;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailForwardersValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa4;

@property (weak, nonatomic) IBOutlet UIImageView *imgEmailList;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailList;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailListValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa5;

@property (weak, nonatomic) IBOutlet UIImageView *imgDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa6;

@property (weak, nonatomic) IBOutlet UIImageView *imgIPAddr;
@property (weak, nonatomic) IBOutlet UILabel *lbIPAddr;
@property (weak, nonatomic) IBOutlet UILabel *lbIPAddrValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa7;

@property (weak, nonatomic) IBOutlet UIImageView *imgSecure;
@property (weak, nonatomic) IBOutlet UILabel *lbSecure;
@property (weak, nonatomic) IBOutlet UILabel *lbSecureValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa8;

@property (weak, nonatomic) IBOutlet UIButton *btnAddCart;

@end

NS_ASSUME_NONNULL_END
