//
//  UIWebView+GUIFixes.h
//  NhanHoa
//
//  Created by Khai Leo on 6/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWebView(GUIFixes)

/**
 *  @brief      The custom input accessory view.
 */
@property (nonatomic, strong, readwrite) UIView* customInputAccessoryView;

/**
 *  @brief      Wether the UIWebView will use the fixes provided by this category or not.
 */
@property (nonatomic, assign, readwrite) BOOL usesGUIFixes;

@end

NS_ASSUME_NONNULL_END
