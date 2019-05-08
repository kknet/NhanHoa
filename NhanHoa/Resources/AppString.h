//
//  AppString.h
//  NhanHoa
//
//  Created by admin on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#ifndef AppString_h
#define AppString_h

#define RobotoBlack         @"Roboto-Black"
#define RobotoBlackItalic   @"Roboto-BlackItalic"
#define RobotoBold          @"Roboto-Bold"
#define RobotoBoldItalic    @"Roboto-BoldItalic"
#define RobotoItalic        @"Roboto-Italic"
#define RobotoLightItalic   @"Roboto-LightItalic"
#define RobotoMedium        @"Roboto-Medium"
#define RobotoMediumItalic  @"Roboto-MediumItalic"
#define RobotoRegular       @"Roboto-Regular"
#define RobotoThin          @"Roboto-Thin"
#define RobotoThinItalic    @"Roboto-ThinItalic"

#define TAG_HUD     100

#define link_api    @"https://nhanhoa.com/app-awk"
#define login_func  @"Login"
#define whois_func  @"Whois"

#define login_mod   @"login"
#define whois_mod   @"whois"

#define logsFolderName      @"LogFiles"
#define login_state         @"login_state"
#define year_for_domain     @"year_for_domain"

#define key_login               @"key_login"
#define key_password            @"key_password"

#define USERNAME ([[NSUserDefaults standardUserDefaults] objectForKey:key_login])
#define PASSWORD ([[NSUserDefaults standardUserDefaults] objectForKey:key_password])

#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define NAV_COLOR [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0]
#define ORANGE_COLOR [UIColor colorWithRed:(249/255.0) green:(157/255.0) blue:(28/255.0) alpha:1.0]
#define TITLE_COLOR [UIColor colorWithRed:(61/255.0) green:(77/255.0) blue:(103/255.0) alpha:1.0]
#define BLUE_COLOR [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0]
#define NEW_PRICE_COLOR [UIColor colorWithRed:(213/255.0) green:(53/255.0) blue:(93/255.0) alpha:1.0]
#define OLD_PRICE_COLOR [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(204/255.0) alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0]

#define N_A         @"Không giá trị"
#define unknown     @"Chưa xác định"

#endif /* AppString_h */
