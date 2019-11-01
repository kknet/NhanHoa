//
//  WhoIsCell.h
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhoIsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *tfDomain;
@property (weak, nonatomic) IBOutlet UIImageView *imgSearch;
@property (weak, nonatomic) IBOutlet UIButton *icRemove;

@end

NS_ASSUME_NONNULL_END
