//
//  ContactInfoViewController.h
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    eContactType,
    eContactName,
    eContactCountry,
    eContactCity,
    eContactDistrict,
    eContactTown,
    eContactGender,
    eContactAddress,
    eContactPhone,
}ContactInfo;

NS_ASSUME_NONNULL_BEGIN

@interface ContactInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateInfo;
- (IBAction)btnUpdateInfoPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
