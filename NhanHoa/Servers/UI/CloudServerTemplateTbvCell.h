//
//  CloudServerTemplateTbvCell.h
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CloudServerTemplateTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrap;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgChecked;

-(void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)setCellIsSelected: (BOOL)selected;

@end

NS_ASSUME_NONNULL_END
