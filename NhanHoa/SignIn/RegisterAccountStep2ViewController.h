//
//  RegisterAccountStep2ViewController.h
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterAccountStep2ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIView *viewAccInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbAccount;
@property (weak, nonatomic) IBOutlet UILabel *lbNumOne;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UIView *viewProfileInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbNumTwo;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

@end

NS_ASSUME_NONNULL_END
