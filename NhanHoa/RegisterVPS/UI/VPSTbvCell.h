//
//  VPSTbvCell.h
//  NhanHoa
//
//  Created by OS on 8/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VPSTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrapper;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbCPU;
@property (weak, nonatomic) IBOutlet UIImageView *imgTickCPU;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa1;

@property (weak, nonatomic) IBOutlet UIImageView *imgTickCore;
@property (weak, nonatomic) IBOutlet UILabel *lbCore;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa2;

@property (weak, nonatomic) IBOutlet UIImageView *imgTickSSD;
@property (weak, nonatomic) IBOutlet UILabel *lbSSD;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa3;

@property (weak, nonatomic) IBOutlet UIImageView *imgTickRAM;
@property (weak, nonatomic) IBOutlet UILabel *lbRAM;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa4;

@property (weak, nonatomic) IBOutlet UIImageView *imgTickIP;
@property (weak, nonatomic) IBOutlet UILabel *lbIP;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa5;

@property (weak, nonatomic) IBOutlet UIImageView *imgTickBandwidth;
@property (weak, nonatomic) IBOutlet UILabel *lbBandwidth;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa6;

@property (weak, nonatomic) IBOutlet UIImageView *imgTickBonus1;
@property (weak, nonatomic) IBOutlet UILabel *lbBonusDirectAdmin;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa7;

@property (weak, nonatomic) IBOutlet UIImageView *imgTickBonus2;
@property (weak, nonatomic) IBOutlet UILabel *lbBonusRAM;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa8;

@property (weak, nonatomic) IBOutlet UITextField *tfTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgArr;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseTime;
@property (weak, nonatomic) IBOutlet UIButton *btnAddCart;


- (void)setupAttrContent;

@end

NS_ASSUME_NONNULL_END
