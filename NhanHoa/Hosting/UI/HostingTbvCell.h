//
//  HostingTbvCell.h
//  NhanHoa
//
//  Created by OS on 11/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HostingTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrap;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UITableView *tbInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UITextField *tfPackage;
@property (weak, nonatomic) IBOutlet UIImageView *imgPackage;
@property (weak, nonatomic) IBOutlet UIButton *btnChoosePackage;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;

@end

NS_ASSUME_NONNULL_END
