//
//  QRCodeViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/3/27.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "QRCodeVC.h"
#import "SGScanningQRCodeView.h"
#import <Photos/Photos.h>
#import "PaySuccessVC.h"


@interface QRCodeVC ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate>{
    UILabel *titleLab;
    UIButton *backBtn;
    UIButton *lightBtn;
    UIButton *photoBtn;
    NSString *scannedResult;
//    PaySuccessViewController * paySeccessVC;
}
@property (nonatomic, strong) AVCaptureDevice *device;
/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) SGScanningQRCodeView *scanningView;

@property (nonatomic, strong) UIButton *right_Button;

@end

@implementation QRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    //添加返回按钮和闪光灯
    [self createBtnToBack];
    [self createBtnToLight];
    //    [self createBtnToPhotoLibrary];
    [self createTitleLabel];
    [self checkDevice];
    
    // 创建扫描边框
    self.scanningView = [[SGScanningQRCodeView alloc] initWithFrame:CGRectMake(0, 0, SCreenWidth, SCreenHegiht) outsideViewLayer:self.view.layer];
    [self.view addSubview:self.scanningView];
    
    [self.view.layer insertSublayer:backBtn.layer above:self.scanningView.layer];
    [self.view.layer insertSublayer:lightBtn.layer above:self.scanningView.layer];
    [self.view.layer insertSublayer:photoBtn.layer above:self.scanningView.layer];
    [self.view.layer insertSublayer:titleLab.layer above:self.scanningView.layer];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
// 移除定时器
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview]; self.scanningView = nil;
    if (self.session) {
        [self.session stopRunning]; self.session = nil;
    }
    if (self.previewLayer) {
        // 2、删除预览图层
        [self.previewLayer removeFromSuperlayer];
        self.previewLayer = nil;
    }
    self.device = nil;
}
- (void)applicationWillEnterForeground {
    [self checkDevice];
}

-(void)checkDevice{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        if (self.session) {
            [self.session stopRunning]; self.session = nil;
        }
        // 判断授权状态
        AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
        if (AVAuthorizationStatusRestricted == AVstatus) {
            DLog(@"未授权，且用户无法更新，如家长控制下");
        }else if (AVAuthorizationStatusNotDetermined == AVstatus){
            DLog(@"未进行 授权选择");
            //访问设备授权延时太长，换成检查相机可用性的方法
            [self takeCamera];
        }else if (AVstatus == AVAuthorizationStatusAuthorized){
            DLog(@"已授权，可使用");
            // 二维码扫描
            [self setupScanningQRCode];
        }else{
            DLog(@"用户拒绝APP使用");
            
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"未获得授权使用摄像头" message:@"请在iOS“设置->隐私->相机”中打开" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    } else {
        DLog(@"请到真机上测试" );
    }
}
- (void)takeCamera
{
    // 相机
    if ([self isCameraAvailable] ) {//&& [self doesCameraSupportTakingPhotos]
        [self setupScanningQRCode];
    }
}
#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    [_session addInput:input];
    
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = CGRectMake(0, 0, SCreenWidth, SCreenHegiht);//self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 会频繁的扫描，调用代理方法
    //正在识别
    // 0、扫描成功之后的提示音
    //    [self playSoundEffect:@"sound.caf"];
    // 1、如果扫描完成，停止会话
    [self.session stopRunning];
    // 2、删除预览图层
    [self.previewLayer removeFromSuperlayer];
    // 3、设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        DLog(@"扫描结果------metadataObjects = %@", obj);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _loadResult:obj];
        });
    }
}
#pragma mark - 扫描结果上传服务器
- (void)_loadResult:(AVMetadataMachineReadableCodeObject *)obj{
    WeakSelf
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:[JJWLogin sharedMethod].loginData.token forKey:@"token"];
    [dict setObject:obj.stringValue forKey:@"auth_code"];
    //以分 计算 传入 都得是整形
    [dict setObject:STRISEMPTY(_amount) ? @(0):@([NSString stringWithFormat:@"%.2f",_amount.floatValue * 100].integerValue) forKey:@"amount"];
    //通道 目前写死
    [dict setObject:@"1" forKey:@"channel_id"];
    [JJWNetworkingTool PostOriginalWithUrl:UnScanCodePay params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [JJWBase alertMessage:@"收款成功!" cb:nil];
        PaySuccessItem * item = [PaySuccessItem yy_modelWithDictionary:responseObject];
        PaySuccessVC * VC = [[PaySuccessVC alloc]init];
        VC.item = item;
        VC.isComeSuccess = YES;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    } failed:^(NSError *error, id chaceResponseObject) {
        [JJWBase alertMessage:error.domain cb:^(BOOL compliont) {
            [weakSelf setupScanningQRCode];
        }];
    }];
}

#pragma mark - - - 扫描提示声
/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    DLog(@"播放完成...");
}

/**
 *  播放音效文件
 *
 *  @param name 音频文件名称
 */
- (void)playSoundEffect:(NSString *)name{
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    // 1、获得系统声音ID
    SystemSoundID soundID = 0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 2、播放音频
    AudioServicesPlaySystemSound(soundID); // 播放音效
}
#pragma mark - - -  从相册中识别码, 并进行界面跳转

- (void)scanQRCodeFromPhotosInTheAlbum:(UIImage *)image {
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
    // 声明一个CIDetector，并设定识别类型 CIDetectorTypeQRCode
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count == 0) {
        [JJWBase alertMessage:@"未发现二维码" cb:nil];
    }else{
        CIQRCodeFeature *feature = [features firstObject];
        scannedResult = feature.messageString;
        DLog(@"result:======%@",scannedResult);
        if (STRISEMPTY(scannedResult)) {
            DLog(@"没有扫描到");
        } else {
            DLog(@"%@",scannedResult);
        }
    }
}

#pragma mark -- camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
#pragma mark - - - 从相册中读取照片
- (void)readImageFromAlbum {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init]; // 创建对象
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
    
    imagePicker.delegate = self; // 指定代理
    [self presentViewController:imagePicker animated:YES completion:nil]; // 显示相册
}

#pragma mark - - - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [self dismissViewControllerAnimated:YES completion:^{
        [self scanQRCodeFromPhotosInTheAlbum:image];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"info - - - %@", info);
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    DLog(@"portraitImg ====%@",portraitImg);
    UIImage *image = (UIImage*)info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self scanQRCodeFromPhotosInTheAlbum:image];
    }];
}
#pragma mark - lazy load
-(void)createTitleLabel{
    if (!titleLab) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, SCreenWidth-200, 40)];
        titleLab.text = @"二维码";
        titleLab.textColor = [UIColor whiteColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:titleLab];
    }
}
-(void)createBtnToBack{
    if (!backBtn) {
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(20, 20, 45, 45);
        backBtn.backgroundColor = [UIColor blackColor];
        backBtn.alpha = 0.5;
        backBtn.layer.cornerRadius = 23;
        [backBtn setImage:[UIImage imageNamed:@"back-arrow"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
        [self.view bringSubviewToFront:backBtn];
    }
    
}
-(void)createBtnToLight{
    if (!lightBtn) {
        lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lightBtn.frame = CGRectMake(SCreenWidth-65, 20, 45, 45);
        lightBtn.backgroundColor = [UIColor blackColor];
        lightBtn.alpha = 0.5;
        lightBtn.layer.cornerRadius = 23;
        [lightBtn setImage:[UIImage imageNamed:@"openLight"] forState:UIControlStateNormal];
        [lightBtn setImage:[UIImage imageNamed:@"closeLight"] forState:UIControlStateSelected];
        [lightBtn addTarget:self action:@selector(light_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:lightBtn];
    }
    
}
-(void)createBtnToPhotoLibrary{
    if (!photoBtn) {
        photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        photoBtn.frame = CGRectMake(SCreenWidth-65, SCreenHegiht-85, 45, 45);
        photoBtn.backgroundColor = [UIColor whiteColor];
        photoBtn.layer.cornerRadius = 23;
        [photoBtn setImage:[UIImage imageNamed:@"openAlumb"] forState:UIControlStateNormal];
        [photoBtn addTarget:self action:@selector(openPhotoLibraryAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:photoBtn];
        [self.view bringSubviewToFront:photoBtn];
    }
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)light_buttonAction:(UIButton *)button {
    if (button.selected == NO) { // 点击打开照明灯
        [self turnOnLight:YES];
        button.selected = YES;
    } else {                                // 点击关闭照明灯
        [self turnOnLight:NO];
        button.selected = NO;
    }
}

- (void)turnOnLight:(BOOL)on {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([_device hasTorch]) {
        [_device lockForConfiguration:nil];
        if (on) {
            [_device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [_device setTorchMode: AVCaptureTorchModeOff];
        }
        [_device unlockForConfiguration];
    }
}

-(void)openPhotoLibraryAction{
    //停止扫描动画
    dispatch_block_t toPhotoLibrary = ^{
        //        [self.scanningView removeTimer];
        //        [self.scanningView removeFromSuperview]; self.scanningView = nil;
        if (self.session) {
            [self.session stopRunning]; self.session = nil;
        }
        if (self.previewLayer) {
            // 2、删除预览图层
            [self.previewLayer removeFromSuperlayer];
            self.previewLayer = nil;
        }
        [self readImageFromAlbum];
    };
    //相册权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册
        DLog(@"家长控制, 无法访问相册");
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"未获得授权使用相册" message:@"请在iOS“设置->隐私->照片”中打开" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
        // 打开相册
        toPhotoLibrary();
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                toPhotoLibrary();
            }else{
                
            }
        }];
    }
    
}



@end
