//
//  HostingPackageTbvCell.h
//  NhanHoa
//
//  Created by OS on 11/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HostingPackageTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrap;
@property (weak, nonatomic) IBOutlet UILabel *lbMonths;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;

-(void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
