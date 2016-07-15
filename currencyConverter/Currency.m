//
//  Currency.m
//  currencyConverter
//
//  Created by Olivia Miller on 7/13/16.
//  Copyright © 2016 Olivia Miller. All rights reserved.
//

#import "Currency.h"

@implementation Currency

@synthesize alphaCode;
@synthesize name;
@synthesize formatter;
@synthesize symbol;
@synthesize decimalPlaces;
@synthesize completionHandlerDictionary;
@synthesize ephemeralConfigObject;
@synthesize numberAsString;

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self =[super init];
    if (self){
        self.name = [aDecoder decodeObjectOfClass:[Currency class] forKey:@"name"];
    self.alphaCode = [aDecoder decodeObjectOfClass:[Currency class] forKey:@"alphaCode"];
    self.name = [aDecoder decodeObjectOfClass:[Currency class]
        forKey:@"decimalPlaces"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.alphaCode forKey:@"alphaCode"];
    [aCoder encodeObject:self.symbol forKey:@"symbol"];
    [aCoder encodeObject:self.decimalPlaces forKey:@"decimalPlaces"];
    }
                 
-(Currency*) initWithName:(NSString*) aName
                alphaCode: (NSString*)aCode
                   symbol: (NSString*)aSymbol
            decimalPlaces:(NSNumber*)places
{
                 self = [super init];
                 if(self){
                     self.alphaCode=aCode;
                     self.symbol=aSymbol;
                     self.name=aName;
                     self.decimalPlaces=places;
                     self.formatter = [[NSNumberFormatter alloc] init];
                     self.formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
                     self.formatter.currencySymbol = aSymbol;
                     self.formatter.maximumFractionDigits = places.integerValue;
                     self.formatter.roundingMode = kCFNumberFormatterRoundHalfUp;
    }
return self;
}

-(NSString*) format: (NSNumber*)quantity{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString* numberAsString = [numberFormatter stringFromNumber:quantity];
    return numberAsString;
}

    -(Currency*) init {
        self = [super init];
        if (self){
            self.completionHandlerDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
            self.ephemeralConfigObject = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        }
        return self;
        
        }
-(void) fetch
{
    NSOperationQueue *mainQueue;
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: self.ephemeralConfigObject delegate:nil delegateQueue: mainQueue];
    for(exchangeRate* i in [exchangeRate allexchangeRates]){
    NSLog(@"dispatching %@", [i description]);
    NSURLSessionTask* task = [delegateFreeSession dataTaskWithURL: [i exchangeRateURL]completionHander:^(NSData *data, NSURLResponse *response, NSError *error){
        NSLog(@"Got response %@ with error%@.\n", response error);
        id obj = [NSJONSerialization JSONObjectWithData: [data
            options: 0
        error: nil];
    if ( [obj isKingOfClass: [NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary*)obj;
        NSLog(@"%@", [dict description]);
    }else{
        NSLog(@"Not a dictionary.");
        exit(1);
    }
    NSLog(@"DATA:\n%@\nEND DATA\n",
          [[NSString alloc] initWithData]: data)
            encoding: NSUTF8StringEncoding]);
    }];
    [task resume];
}
}
@end