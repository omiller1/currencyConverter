//
//  ViewController.h
//  currencyConverter
//
//  Created by Olivia Miller on 7/13/16.
//  Copyright © 2016 Olivia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *inputHome;

@property (weak, nonatomic) IBOutlet UILabel *homeInputLabel;

@property (weak, nonatomic) IBOutlet UILabel *foreignOutputLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerForeign;

@property (strong, nonatomic) NSArray *exchangeRate;

@property (strong, nonatomic) NSArray *pickerData;

@end