//
//  TransHistoryViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbNoData;
@property (weak, nonatomic) IBOutlet UILabel *lbBottomSepa;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;

@property (nonatomic, strong) NSMutableDictionary *dataDict;

@end
