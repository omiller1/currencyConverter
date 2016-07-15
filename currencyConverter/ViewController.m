//
//  ViewController.m
//  currencyConverter
//
//  Created by Olivia Miller on 7/13/16.
//  Copyright © 2016 Olivia Miller. All rights reserved.
//
#import "ViewController.h"
#import "Currency.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize pickerData;
@synthesize Currency;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerData = [Currency pickerData];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    self.pickerForeign.dataSource = self;
    self.pickerForeign.delegate = self;
    
    //  self.pickerDataForeign.dataSource = self;
    //  self.pickerDataForeign.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerData.count;
}


// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData [row];
}



@end