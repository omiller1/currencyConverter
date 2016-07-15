//
//  exchangeRate.m
//  currencyConverter
//
//  Created by Olivia Miller on 7/13/16.
//  Copyright © 2016 Olivia Miller. All rights reserved.
//

#import "exchangeRate.h"
#import <Foundation/Foundation.h>

@interface exchangeRate : NSObject
@property (strong) NSString* homeCurrency;
@property (strong) NSString* foreignCurrency;
@property (strong) NSString* queryString;
@property (strong) NSData* exchangeRateJSON;

-(exchangeRate*) initWithHomeCurrency: (NSString*) aHomeCurrency foreignCurrency: (NSString*) aForeignCurrency;
-(NSURL*) exchangeRateURL;
+(NSArray*) allexchangeRates;

@end
@implementation exchangeRate
@synthesize foreignCurrency;
@synthesize homeCurrency;

-(exchangeRate*) initWithHomeCurrency: (NSString*) aHomeCurrency foreignCurrency: (NSString*) aForeignCurrency
{
    self = [super init];
    if(self){
        foreignCurrency = aForeignCurrency;
        homeCurrency = aHomeCurrency;
    }
    return self;
}

-(NSString*) description
{
    return [NSString stringWithFormat: @"%@ %@", self.homeCurrency, self.foreignCurrency];
}

-(NSURL*) exchangeRateURL
{
    NSString* urlString = [NSString stringWithFormat: @"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.xchange%%20where%%20pair%%20in%%20(%%22%@%@%%22)&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys&callback=", self.homeCurrency, self.foreignCurrency];
    queryString = [queryString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return [NSURL URLWithString: urlString];
    NSData* exchangeRateJSON = [[NSString stringWithContentsOfURL:[NSURL URLWithString:queryString]
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    
    Objective-C
    
    // Check that the JSON is valid
    if (exchangeRateJSON) {
        NSDictionary* exchangeRateData = [NSJSONSerialization JSONObjectWithData:exchangeRateJSON options:0 error:nil];
        
        // Check that the JSON contains valid data for the fields
        if (exchangeRateData &&
            exchangeRateData[@"query"] &&
            exchangeRateData[@"query"][@"results"] && exchangeRateData[@"query"][@"results"][@"rate"] &&
            exchangeRateData[@"query"][@"results"][@"rate"][@"Rate"]) {
            
            // Retrieve the exchange rate field
            NSString* currentExchangeRate = exchangeRateData[@"query"][@"results"][@"rate"][@"Rate"];
            
            // Final check to make sure the exchange rate is valid
            if (currentExchangeRate && ([currentExchangeRate length] > 0)) {
                // Convert the exchange rate string back to a floating point number
                double exchangeRateValue = [currentExchangeRate doubleValue];
                
                // Run any required logic using the exchange rate back on the main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Exchange rate is %lf", exchangeRateValue);
                });
            }
        }
    }

+(NSArray*) allexchangeRates
{
    NSMutableArray* allRates = [[NSMutableArray alloc] init];
    [allRates addObject: [[exchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"GBP"]];
    [allRates addObject: [[exchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"CNY"]];
    [allRates addObject: [[exchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"AUS"]];
    [allRates addObject: [[exchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"EUR"]];
    [allRates addObject: [[exchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"CAD"]];
    return (NSArray*)allRates;
}
@end
@interface URLFetcherExample : NSObject
-(void) fetch;
@end
@interface URLFetcherExample ()
@property (strong) NSMutableDictionary *completionHandlerDictionary;
@property (strong) NSURLSessionConfiguration *ephemeralConfigObject;
@end

@implementation URLFetcherExample
@synthesize completionHandlerDictionary;
@synthesize ephemeralConfigObject;

-(URLFetcherExample*) init
{
    self = [super init];
    if(self){
        completionHandlerDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
        ephemeralConfigObject = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    }
    return self;
}

-(void) fetch
{
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: self.ephemeralConfigObject delegate: nil delegateQueue: mainQueue];
    for(exchangeRate* i in [exchangeRate allexchangeRates]){
        NSLog(@"dispatching %@", [i description]);
        NSURLSessionTask* task = [delegateFreeSession dataTaskWithURL: [i exchangeRateURL]
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSLog(@"Got response %@ with error %@.\n", response, error);
    id obj = [NSJSONSerialization JSONObjectWithData: data
    options: 0
        error: nil];
    if( [obj isKindOfClass: [NSDictionary class]] ){
    NSDictionary *dict = (NSDictionary*)obj;
    NSLog(@"%@", [dict description]);
        }else{
    NSLog(@"Not a dictionary.");
        exit(1);
            }
    /*NSLog(@"DATA:\n%@\nEND DATA\n",
    [[NSString alloc] initWithData: data
    encoding: NSUTF8StringEncoding]);*/
            }];
        [task resume];
    }

    NSDictionary* dict = (NSDictionary*)obj;
    NSDictionary* queryDict = [dict objectForKey:@"query"];
    NSDictionary* resultsDict = [queryDict objectForKey:@"rsults"];
    NSDictionary* rateDict = [resultsDict objectForKey:@"rate"];
    NSString* rateString = [rateDict objectforKey:@"Rate"];
    self.rate = @(rateString.floatValue);
    
}
@end
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SInt32 res = 0;
        URLFetcherExample* f = [[URLFetcherExample alloc] init];
        [f fetch];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    return 0;
}

exchangeRate* exchangeRate = ...; // Exchange rate already allocated and initialized
NSString* urlString = [NSString stringWithFormat: @"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22%@%@%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=", exchangeRate.home.alphaCode, exchangeRate.foreign.alphaCode];

@end
