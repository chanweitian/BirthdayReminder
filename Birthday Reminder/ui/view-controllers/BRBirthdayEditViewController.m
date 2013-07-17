//
//  BRBirthdayEditViewController.m
//  Birthday Reminder
//
//  Created by Administrator on 17/07/13.
//  Copyright (c) 2013 Chan. All rights reserved.
//

#import "BRBirthdayEditViewController.h"

@interface BRBirthdayEditViewController ()

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation BRBirthdayEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIImagePickerController *) imagePicker {
    if (_imagePicker == nil){
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

- (void) takePhoto {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void) pickPhoto {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateSaveButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapPhoto:(id)sender {
    NSLog(@"Did Tap Photo!");
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"No camera detected!");
        [self pickPhoto];
        return;
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Take a Photo",@"Pick from Photo Library", nil];
    [actionSheet showInView:self.view];
    
}

- (IBAction)didChangeNameText:(id)sender {
    NSLog(@"The text was changed to: %@", self.nameTextField.text);
    [self updateSaveButton];
}

- (IBAction)didToggleSwitch {
    if(self.includeYearSwitch.on){
        NSLog(@"Sure, I'll share my age with you!");
    }else {
        NSLog(@"I'd prefer to keep my birthday year to myself thank you very much!");
    }
}
- (IBAction)didChangeDatePicker:(id)sender {
    NSLog(@"New Birthdate Selected: %@",self.datePicker.date);
    
}

- (void) updateSaveButton {
    self.saveButton.enabled = self.nameTextField.text.length > 0;
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameTextField resignFirstResponder];
    return NO;
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self pickPhoto];
            break;
        default:
            break;
    }
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.photoView.image = image;
    
}


@end
