#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <Vision/Vision.h>
#import <QuartzCore/CABase.h>
#import <EKMetalKit/EKMetalKit.h>
#import <KVOController/KVOController.h>
#import <Masonry/Masonry.h>

#import "ViewController.h"
#import "NSString+XDIPValiual.h"
#import "UIStoryboard+XDStoryboard.h"
#import "XDLive2DControlViewController.h"
#import "XDLive2DCaptureViewController.h"
@interface ViewController ()

@property (nonatomic, strong) XDLive2DControlViewController *controlViewController;
@property (nonatomic, strong) XDLive2DCaptureViewController *captureViewController;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.captureViewController = [[XDLive2DCaptureViewController alloc] initWithModelName:@"sirosaku"];
    [self.view addSubview:self.captureViewController.view];
    [self addChildViewController:self.captureViewController];
    [self.captureViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.controlViewController = (XDLive2DControlViewController *)[UIStoryboard xd_viewControllerWithClass:[XDLive2DControlViewController class]];
    [self.view addSubview:self.controlViewController.view];
    [self addChildViewController:self.controlViewController];
    [self.controlViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.controlViewController attachCaptureViewModel:self.captureViewController.viewModel];
    
    [self bindData];
    [self setupGesture];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)bindData {
    __weak typeof(self) weakSelf = self;
    [self.controlViewController addKVOObserver:self forKeyPath:FBKVOKeyPath(_controlViewController.needShowCamera) block:^(id  _Nullable oldValue, id  _Nullable newValue) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.captureViewController.liveview.hidden = ![newValue boolValue];
        });
    }];
    self.captureViewController.liveview.hidden = !self.controlViewController.needShowCamera;
    
    [self.captureViewController addKVOObserver:self
                                    forKeyPath:FBKVOKeyPath(_captureViewController.viewModel.isCapturing)
                                         block:^(id  _Nullable oldValue, id  _Nullable newValue) {
        if (![newValue boolValue]) {
            /// 结束捕捉的时候要回中模型
            [weakSelf.captureViewController resetModel];
        }
    }];
}

- (void)setupGesture {
    UITapGestureRecognizer *moveControlPannelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMoveControlPannelGesture:)];
    moveControlPannelGesture.numberOfTouchesRequired = 2;
    moveControlPannelGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:moveControlPannelGesture];
    
    UITapGestureRecognizer *moveCameraPreviewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMoveCameraPreviewGesture:)];
    moveCameraPreviewGesture.numberOfTapsRequired = 2;
    moveCameraPreviewGesture.numberOfTouchesRequired = 3;
    [self.view addGestureRecognizer:moveCameraPreviewGesture];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*if (self.expressionCount == 0) return;
    static NSInteger index = 0;
    index += 1;
    if (index == self.expressionCount) {
        index = 0;
    }
    [self.model startExpressionWithName:self.model.expressionName[index]];*/
}

#pragma mark - Action
- (void)handleMoveControlPannelGesture:(UIGestureRecognizer *)gesture {
    CGPoint p = [gesture locationInView:self.view];
    [self.controlViewController layoutControlPannelSwitchStackViewWithPoint:p];
}

- (void)handleMoveCameraPreviewGesture:(UIGestureRecognizer *)gesture {
    CGPoint p = [gesture locationInView:self.view];
    [self.captureViewController layoutCameraPreviewViewWithPoint:p];
}
@end
