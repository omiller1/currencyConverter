//
//  exchangeRate.h
//  currencyConverter
//
//  Created by Olivia Miller on 7/13/16.
//  Copyright © 2016 Olivia Miller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface exchangeRate : NSObject <NSCoding>
@property (strong, nonatomic) homeInputLabel* picker;
@property (strong, nonatomic) foreignOutputLabel* pickerForeign;
@property (strong, nonatomic) NSNumber* rate;
@property (strong, nonatomic) NSDate* expiresOn;
- (bool) updateRate;
-(NSString*) exchangeToHome : (NSNumber*)value;
-(NSString*) exchangeToForeign:(NSNumber*) value;
-(void) reverse;
-(NSString*) name;
-(NSString*) description;
-(exchangeRate*) initWithHome:(inputCurrency*)aHome foreign:(Currency*) aForeign;
@end