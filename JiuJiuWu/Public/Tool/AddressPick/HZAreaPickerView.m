//
//  HZAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>
#define PICKVIEW_HEIGHT 240

#define kDuration 0.3

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities, *areas;
    NSArray *baseProvinces,*baseCities, *baseAreas;
    
}
- (void)showInView;
- (void)cancelPicker;
- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize pickerStyle=_pickerStyle;
@synthesize locate=_locate;
@synthesize locatePicker = _locatePicker;


-(HZLocation *)locate
{
    if (_locate == nil)
    {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle delegate:(id<HZAreaPickerDelegate>)delegate
{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HZAreaPickerView" owner:self options:nil] objectAtIndex:0];
    if (self)
    {
        self.frame = CGRectMake(0, SCreenHegiht - NAVIGATION_BAR_HEIGHT, SCreenWidth, SCreenHegiht - NAVIGATION_BAR_HEIGHT);
        self.delegate = delegate;
        self.pickerStyle = pickerStyle;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        
        NSDictionary *addressData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
                                     
        baseProvinces = [addressData valueForKey:@"province"];
        baseCities = [addressData valueForKey:@"city"];
        baseAreas = [addressData valueForKey:@"area"];
        
        //加载数据
        if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict)
        {
            provinces = baseProvinces;//获取所有的省
            
            NSString *pid = [[provinces firstObject] valueForKey:@"pid"];
            cities  = [self getShowArrayForArray:baseCities withParentKey:pid forChildKey:@"pid"];
            
            NSString *cid = [[cities firstObject] valueForKey:@"cid"];
            areas  = [self getShowArrayForArray:baseAreas withParentKey:cid forChildKey:@"cid"];
            
            self.locate.state = [[provinces firstObject] valueForKey:@"name"];
            self.locate.stateId = [[provinces firstObject] valueForKey:@"pid"];
            
            self.locate.city  = [[cities firstObject] valueForKey:@"name"];
            self.locate.cityId  = [[cities firstObject] valueForKey:@"cid"];
            if (areas.count > 0)
            {
                self.locate.district = [[areas objectAtIndex:0] valueForKey:@"name"];
                self.locate.districtId = [[areas objectAtIndex:0] valueForKey:@"aid"];
            }
            else
            {
                self.locate.district = @"";
                self.locate.districtId = @"";
            }
        }else{
            provinces = baseProvinces;//获取所有的省
            
            NSString *pid = [[provinces firstObject] valueForKey:@"pid"];
            cities  = [self getShowArrayForArray:baseCities withParentKey:pid forChildKey:@"pid"];
            
            self.locate.state = [[provinces firstObject] valueForKey:@"name"];
            self.locate.stateId = [[provinces firstObject] valueForKey:@"pid"];
            
            self.locate.city  = [[cities firstObject] valueForKey:@"name"];
            self.locate.cityId  = [[cities firstObject] valueForKey:@"cid"];
            self.locate.district = @"";
            self.locate.districtId = @"";
        }
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction:)];
        [self addGestureRecognizer:tap];
        
        [self showInView];
    }
        
    return self;
    
}

-(NSArray *)getShowArrayForArray:(NSArray *)Array withParentKey:(NSString *)parentID forChildKey:(NSString *)childKey
{
    NSMutableArray *showCityAry = [[NSMutableArray alloc]init];
    for (NSDictionary *cityDict in Array)
    {
        if ([[cityDict valueForKey:childKey] isEqual:parentID])
        {
            [showCityAry addObject:cityDict];
        }
    }
    return [showCityAry copy];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict)
    {
        return 3;
    }
    else
    {
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict)
            {
                return [areas count];
                break;
            }
        default:
            return 0;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textColor = [UIColor blackColor];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"name"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"name"];
                break;
            case 2:
                if ([areas count] > 0) {
                    return [[areas objectAtIndex:row] valueForKey:@"name"];
                    break;
                }
            default:
                return  @"";
                break;
        }
    } else
    {
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"name"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"name"];
                break;
            default:
                return @"";
                break;
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict)
    {
        if (component == 0){
            self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"name"];
            self.locate.stateId = [[provinces objectAtIndex:row] objectForKey:@"pid"];
            NSString *pid = [[provinces objectAtIndex:row] objectForKey:@"pid"];
            
            cities = [self getShowArrayForArray:baseCities withParentKey:pid forChildKey:@"pid"];
            self.locate.city = [[cities firstObject] objectForKey:@"name"];
            self.locate.cityId = [[cities firstObject] objectForKey:@"cid"];
            
            [self.locatePicker reloadComponent:1];
            [self.locatePicker selectRow:0 inComponent:1 animated:YES];
            
            NSString *cid = [[cities firstObject] objectForKey:@"cid"];
            areas = [self getShowArrayForArray:baseAreas withParentKey:cid forChildKey:@"cid"];
            [self.locatePicker reloadComponent:2];
            [self.locatePicker selectRow:0 inComponent:2 animated:YES];
            if ([areas count] > 0)
            {
                self.locate.district = [[areas firstObject] valueForKey:@"name"];
                self.locate.districtId = [[areas firstObject] valueForKey:@"aid"];
            }
            else
            {
                self.locate.district = @"";
                self.locate.districtId = @"";
            }

        }else if (component==1){
            self.locate.city = [[cities  objectAtIndex:row] objectForKey:@"name"];
            self.locate.cityId = [[cities  objectAtIndex:row] objectForKey:@"cid"];
            NSString *cid = [[cities objectAtIndex:row] objectForKey:@"cid"];
            
            areas = [self getShowArrayForArray:baseAreas withParentKey:cid forChildKey:@"cid"];
            [self.locatePicker reloadComponent:2];
            [self.locatePicker selectRow:0 inComponent:2 animated:YES];
            if ([areas count] > 0)
            {
                self.locate.district = [[areas firstObject] valueForKey:@"name"];
                 self.locate.district = [[areas firstObject] valueForKey:@"aid"];
            }
            else
            {
                self.locate.district = @"";
                self.locate.districtId = @"";
            }

        }else if (component==2){
            if ([areas count] > 0)
            {
                self.locate.district = [[areas objectAtIndex:row] valueForKey:@"name"];
                self.locate.districtId = [[areas objectAtIndex:row] valueForKey:@"aid"];
            }
            else
            {
                self.locate.district = @"";
                self.locate.districtId = @"";
            }
        }
    }else{
        if (component == 0){
            self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"name"];
            self.locate.stateId = [[provinces objectAtIndex:row] objectForKey:@"pid"];
            NSString *pid = [[provinces objectAtIndex:row] objectForKey:@"pid"];
            
            cities = [self getShowArrayForArray:baseCities withParentKey:pid forChildKey:@"pid"];
            self.locate.city = [[cities firstObject] objectForKey:@"name"];
            self.locate.cityId = [[cities firstObject] objectForKey:@"cid"];
            
            [self.locatePicker reloadComponent:1];
            [self.locatePicker selectRow:0 inComponent:1 animated:YES];
            
        }else if (component==1){
            
            self.locate.city = [[cities  objectAtIndex:row] objectForKey:@"name"];
            self.locate.cityId = [[cities  objectAtIndex:row] objectForKey:@"cid"];
        }
    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)])
    {
        [self.delegate pickerDidChaneStatus:self];
    }
}

#pragma mark - animation

- (void)showInView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0,SCreenWidth, SCreenHegiht - NAVIGATION_BAR_HEIGHT);
    }];
    
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0,SCreenHegiht - NAVIGATION_BAR_HEIGHT, SCreenWidth, SCreenHegiht - NAVIGATION_BAR_HEIGHT);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}


- (IBAction)doneAction:(id)sender
{
    [self cancelPicker];
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)])
    {
        [self.delegate pickerDidChaneStatus:self];
    }
    
}

- (IBAction)cancelAction:(id)sender {
    [self cancelPicker];
}

@end
