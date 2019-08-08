//
//  RegisterSSLViewController.h
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterSSLViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnComodo;
@property (weak, nonatomic) IBOutlet UIButton *btnGeoTrust;
@property (weak, nonatomic) IBOutlet UIButton *btnSymantic;

@property (weak, nonatomic) IBOutlet UITableView *tbContent;

- (IBAction)btnComodoSSLPress:(UIButton *)sender;
- (IBAction)btnGeoTrustSSLPress:(UIButton *)sender;
- (IBAction)btnSymanticSSLPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
