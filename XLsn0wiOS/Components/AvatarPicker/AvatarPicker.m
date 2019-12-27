
#import "AvatarPicker.h"
#import "XLsn0wActionSheet.h"
#import "XLsn0wiOSHeader.h"

@interface AvatarPicker() <XLsn0wActionSheetDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end
//用到此类的时候初始化
static AvatarPicker *imagePickerInstance = nil;

@implementation AvatarPicker

+ (void)show:(BOOL)allowsEditing finishAction:(ImagePickerFinishAction)finishAction {
    if (imagePickerInstance == nil) {
        imagePickerInstance = [[AvatarPicker alloc] init];
    }
    [imagePickerInstance show:allowsEditing finishAction:finishAction];
}

- (void)showXLsn0wActionSheet {
    XLsn0wActionSheet *actionSheet = [XLsn0wActionSheet sheetWithTitle:@""
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                     otherButtonTitles:@"拍照", @"相册获取", nil];
    [actionSheet setButtonColor:AppBlackTextColor];
    [actionSheet show];
    actionSheet.tag = 5000;
}

- (void)actionSheet:(XLsn0wActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex: %d", (int)buttonIndex);
    if (actionSheet.tag == 5000) {
        if (buttonIndex == 1) {
            //拍照
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *PickerImage = [[UIImagePickerController alloc] init];
                PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
                PickerImage.allowsEditing = true;
                PickerImage.delegate = self;
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:PickerImage animated:YES completion:nil];
            }
        } else if (buttonIndex == 2) {
            //从相册选择
            //初始化UIImagePickerController
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //允许编辑，即放大裁剪
            PickerImage.allowsEditing = true;
            //自代理
            PickerImage.delegate = self;
            //页面跳转
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:PickerImage animated:YES completion:nil];
        }
    }
    
}

- (void)show:(BOOL)allowsEditing finishAction:(ImagePickerFinishAction)finishAction {
    self.finishAction = finishAction;
    
//    [self showXLsn0wActionSheet];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    //拍照
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc] init];
            PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            PickerImage.allowsEditing = allowsEditing;
            PickerImage.delegate = self;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:PickerImage animated:YES completion:nil];
        }]];
    }

    //从相册选择
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = allowsEditing;
        //自代理
        PickerImage.delegate = self;
        //页面跳转

        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:PickerImage animated:YES completion:nil];
    }]];


    //取消按钮，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    if (self.finishAction) {
        self.finishAction(image);
    }
   
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    imagePickerInstance = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    if (_finishAction) {
//        _finishAction(nil);
//    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    imagePickerInstance = nil;
}

@end
