//
//  Currency.h
//  currencyConverter
//
//  Created by Olivia Miller on 7/13/16.
//  Copyright © 2016 Olivia Miller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "exchangeRate.h"

@interface Currency : NSObject <NSCoding>

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* alphaCode;
@property (strong, nonatomic) NSString* symbol;
@property (strong, nonatomic) NSNumberFormatter* formatter;
@property (strong, nonatomic) NSNumber* decimalPlaces;

-(Currency*) initWithName:(NSString*) aName
                alphaCode: (NSString*)aCode
                   symbol: (NSString*)aSymbol
            decimalPlaces:(NSNumber*)places;
-(NSString*) format:(NSNumber*) quantity;

@property(strong) NSMutableDictionary *completionHandlerDictionary;
@property(strong) NSURLSessionConfiguration *ephemeralConfigObject;
-(void)fetch;

@property (strong, nonatomic) NSString* numberAsString;

@end