//
//  WindowsHostingCell.h
//  NhanHoa
//
//  Created by OS on 8/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WindowsHostingCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *viewWrapper;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbMemory;
@property (weak, nonatomic) IBOutlet UILabel *lbMemoryValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa1;

@property (weak, nonatomic) IBOutlet UILabel *lbBandwidth;
@property (weak, nonatomic) IBOutlet UILabel *lbBandwidthValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa2;

@property (weak, nonatomic) IBOutlet UILabel *lbFTP;
@property (weak, nonatomic) IBOutlet UILabel *lbFTPValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa3;

@property (weak, nonatomic) IBOutlet UILabel *lbMySQL;
@property (weak, nonatomic) IBOutlet UILabel *lbMySQLValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa4;

@property (weak, nonatomic) IBOutlet UILabel *lbMSSQL;
@property (weak, nonatomic) IBOutlet UILabel *lbMSSQLValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa5;

@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa6;

@property (weak, nonatomic) IBOutlet UILabel *lbSubdomain;
@property (weak, nonatomic) IBOutlet UILabel *lbSubdomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa7;

@property (weak, nonatomic) IBOutlet UILabel *lbAliasOrParkDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbAliasOrParkDomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa8;

@property (weak, nonatomic) IBOutlet UILabel *lbAmount;
@property (weak, nonatomic) IBOutlet UITextField *tfAmount;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrAmount;
@property (weak, nonatomic) IBOutlet UIButton *btnAmount;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa9;

@property (weak, nonatomic) IBOutlet UIButton *btnAddCart;
@property (weak, nonatomic) IBOutlet UICollectionView *clvAmount;

- (IBAction)btnAmountPress:(UIButton *)sender;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float paddingContent;

@end

NS_ASSUME_NONNULL_END
