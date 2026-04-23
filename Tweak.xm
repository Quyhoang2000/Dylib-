#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface QuyHoangWindow : UIWindow
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIButton *btnMenu;
@end

@implementation QuyHoangWindow
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar + 100.0;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = NO;

        self.btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnMenu.frame = CGRectMake(30, 150, 55, 55);
        [self.btnMenu setTitle:@"FXY" forState:UIControlStateNormal];
        self.btnMenu.backgroundColor = [UIColor blackColor];
        self.btnMenu.layer.cornerRadius = 27.5;
        [self.btnMenu addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 310, 460)];
        self.webView.center = self.center;
        self.webView.hidden = YES;
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;

        // DÁN CHUỖI BASE64 VÀO ĐÂY
        NSString *b64 = @"CHUỖI_BASE64_CỦA_ÔNG";
        NSData *data = [[NSData alloc] initWithBase64EncodedString:b64 options:0];
        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        [self.webView loadHTMLString:html baseURL:nil];
        [self addSubview:self.webView];
        [self addSubview:self.btnMenu];
    }
    return self;
}
- (void)toggle { self.webView.hidden = !self.webView.hidden; }
@end

static QuyHoangWindow *menu;
%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)arg1 {
    %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        menu = [[QuyHoangWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
}
%end
