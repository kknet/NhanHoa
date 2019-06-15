//
//  DomainResultView.h
//  NhanHoa
//
//  Created by Khai Leo on 6/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainResultView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;

- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
