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

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UIImageView *imgInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbVersion;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbReleaseDate;

@property (weak, nonatomic) IBOutlet UIButton *btnCheckUpdate;

- (IBAction)btnCheckUpdatePress:(UIButton *)sender;
- (IBAction)icBackClick:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
