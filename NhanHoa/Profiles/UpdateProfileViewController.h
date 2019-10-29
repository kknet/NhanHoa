//
//  UpdateProfileViewController.h
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

- (IBAction)icBackClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
