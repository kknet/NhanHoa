//
//  DomainDNSViewController.h
//  NhanHoa
//
//  Created by OS on 7/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainDNSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbNoData;
@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UITableView *tbRecords;

@property (nonatomic, strong) NSString *domainName;

@end

NS_ASSUME_NONNULL_END
