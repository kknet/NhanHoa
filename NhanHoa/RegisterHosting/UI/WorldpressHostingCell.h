//
//  WorldpressHostingCell.h
//  NhanHoa
//
//  Created by OS on 8/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorldpressHostingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrapper;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbAmount;
@property (weak, nonatomic) IBOutlet UITextField *tfAmount;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UIImageView *imgArr;
@property (weak, nonatomic) IBOutlet UIButton *btnAmount;

@property (weak, nonatomic) IBOutlet UIButton *btnAddCart;

@end

NS_ASSUME_NONNULL_END
