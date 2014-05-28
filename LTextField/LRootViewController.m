//
//  LRootViewController.m
//  LTextField
//
//  Created by leo on 5/27/14.
//  Copyright (c) 2014 leo. All rights reserved.
//

#import "LRootViewController.h"
#import "LTextField.h"

@interface LRootViewController ()<LTextFieldDelegate>

@end

@implementation LRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    LTextField * textField = [[LTextField alloc]initWithFrame:CGRectMake(10, 30, 300, 70)];
    textField.placeHolder = @"求是潮通行证";
    [self.view addSubview:textField];
}

- (void)textFieldDidEndEditing:(LTextField *)textField
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
