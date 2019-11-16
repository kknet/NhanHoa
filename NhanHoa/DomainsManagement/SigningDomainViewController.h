//
//  SigningDomainViewController.h
//  NhanHoa
//
//  Created by Khai Leo on 6/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SigningDomainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIWebView *wvContent;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *icWaiting;

@property (nonatomic, strong) NSString *domain_signed_url;
@property (nonatomic, strong) NSString *domain_signing_url;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
