//
//  AboutViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 6/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AboutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgApp;
@property (weak, nonatomic) IBOutlet UILabel *lbVersion;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckUpdate;
@property (weak, nonatomic) IBOutlet UILabel *lbCompany;

- (IBAction)btnCheckUpdatePress:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
