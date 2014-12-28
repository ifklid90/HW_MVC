//
//  ViewController.m
//  HW_MVC
//
//  Created by User on 28.12.14.
//  Copyright (c) 2014 User. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"there");
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"textFieldValue"];
    if (str)
        self.textField.text = str;
    NSLog(@" wow");
    NSNumber *check = [[NSUserDefaults standardUserDefaults] objectForKey:@"switchValue"];
    check = check ? check : @0;
    [self.mySwitch setOn:check.boolValue animated:NO];
    
    NSNumber *select = [[NSUserDefaults standardUserDefaults] objectForKey:@"segmentValue"];
    select = select ? select : @0;
    self.segment.selectedSegmentIndex = select.integerValue;
    
    NSNumber *sliderValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"sliderValue"];
    sliderValue = sliderValue ? sliderValue : @10;
    self.slider.value = sliderValue.floatValue;
    
    NSData *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"buttonColorValue"];
    if (color)
        [self.btn setTintColor:[NSKeyedUnarchiver unarchiveObjectWithData:color]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    UIColor *color = [self randColor];
    [self.btn setTintColor:color];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:color] forKey:@"buttonColorValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"button pressed");
}
- (IBAction)segmentChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[[NSNumber alloc] initWithInteger:self.segment.selectedSegmentIndex] forKey:@"segmentValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"segment changed");
}
- (IBAction)switchChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[[NSNumber alloc] initWithBool:self.mySwitch.isOn] forKey:@"switchValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)sliderChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[[NSNumber alloc] initWithFloat:self.slider.value] forKey:@"sliderValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)textFieldChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:@"textFieldValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UIColor *)randColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

@end
