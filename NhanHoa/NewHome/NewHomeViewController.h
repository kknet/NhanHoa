//
//  NewHomeViewController.h
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    eMenuDomain,
    eMenuCloudServer,
    eMenuVfone,
    eMenuOrders,
    eMenuProfiles,
    eMenuRegisterEmail,
    eMenuHosting,
    eMenuMore,
}NewHomeLayoutType;

@interface NewHomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewBanner;
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTop;
@property (weak, nonatomic) IBOutlet UICollectionView *clvMenu;


@end

NS_ASSUME_NONNULL_END
