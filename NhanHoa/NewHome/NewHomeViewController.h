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
    eMenuRegisterDomains,
    eMenuHosting,
    eMenuCloudVPS,
    eMenuCloudServer,
    eMenuDomainsManagement,
    eMenuRegisterEmail,
    eMenuOrdersManagement,
    eMenuMore,
}NewHomeLayoutType;

@interface NewHomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTop;
@property (weak, nonatomic) IBOutlet UICollectionView *clvMenu;
@property (weak, nonatomic) IBOutlet UILabel *lbCopyRight;


@end

NS_ASSUME_NONNULL_END
