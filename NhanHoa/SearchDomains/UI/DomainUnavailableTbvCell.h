//
//  DomainUnavailableTbvCell.h
//  NhanHoa
//
//  Created by OS on 11/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainUnavailableTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrap;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
@property (weak, nonatomic) IBOutlet UILabel *lbTopDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDesc;

@property (weak, nonatomic) IBOutlet UITableView *tbSubs;

@end

NS_ASSUME_NONNULL_END
