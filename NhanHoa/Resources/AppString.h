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

#define TAG_HUD             100
#define TIME_FOR_SLIDER     6
#define COUNTRY_CODE        @"231"

#define MERCHANT_ID         @"ONEPAY"
#define ACCESSCODE          @"D67342C2"
#define HASHCODE            @"A3EFDFABA8653DF2342E8DAC29B51AF0"

#define MERCHANT_ID_VISA    @"TESTONEPAY"
#define ACCESSCODE_VISA     @"6BEB2546"
#define HASHCODE_VISA       @"6D0870CDE5F24F34F3915FB0045120DB"

#define Approved_Code               @"0"
#define Bank_Declined_Code          @"1"
#define Merchant_not_exist_Code     @"3"
#define Invalid_access_Code         @"4"
#define Invalid_amount_Code         @"5"
#define Invalid_currency_Code       @"6"
#define Unspecified_failure_Code    @"7"
#define Invalid_card_number_Code    @"8"
#define Invalid_card_name_Code      @"9"
#define Expired_card_Code           @"10"
#define Card_not_registed_Code      @"11"
#define Invalid_card_date_Code      @"12"
#define Exist_Amount_Code           @"13"
#define Insufficient_fund_Code      @"21"
#define User_cancel_Code            @"99"
#define Failured_Content            @"Giao dịch thất bại"

#define return_url          @"https://api.websudo.xyz/dr.php"
#define link_api            @"https://nhanhoa.com/app-awk"
#define login_func          @"Login"
#define whois_func          @"Whois"
#define get_profile_func    @"ListContact"


#define login_mod       @"login"
#define whois_mod       @"whois"
#define get_profile_mod @"contact_list"


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
#define GREEN_COLOR [UIColor colorWithRed:(28/255.0) green:(189/255.0) blue:(92/255.0) alpha:1.0]
#define NEW_PRICE_COLOR [UIColor colorWithRed:(213/255.0) green:(53/255.0) blue:(93/255.0) alpha:1.0]
#define OLD_PRICE_COLOR [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(204/255.0) alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0]

#define N_A         @"Không giá trị"
#define unknown     @"Chưa xác định"

#define text_personal @"Cá nhân"
#define text_business @"Doanh nghiệp"

#endif /* AppString_h */
