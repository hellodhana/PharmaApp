#import "MBRoundProgressView.h"
#define forcolor(x) x/255.0f

@interface MBRoundProgressView()  {
@private
    float _progress;
}
@end

@implementation MBRoundProgressView
@synthesize progresslabel;
#pragma mark -
#pragma mark Accessors

- (float)progress {
    return _progress;
}

- (void)setProgress:(float)progress{
    _progress = progress;
    [self setNeedsDisplay];  
}

#pragma mark -
#pragma mark Lifecycle

- (id)init {
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 37.0f, 37.0f)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
   
    CGFloat lineWidth = 5.f;
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = lineWidth;
    processBackgroundPath.lineCapStyle = kCGLineCapRound;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = (self.bounds.size.width - lineWidth)/2;
    CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0] set];
    [processBackgroundPath stroke];
    // Draw progress
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapRound;
    processPath.lineWidth = lineWidth;
    endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    if(_progress<0.85){
        [[UIColor colorWithRed:251.0/255.0 green:93.0/255.0 blue:125.0/255.0 alpha:1.0] set];
    }
    else if(_progress>=0.85 && _progress<=0.95){
        [[UIColor colorWithRed:255.0/255.0 green:149.0/255.0 blue:63.0/255.0 alpha:1.0] set];
    }
    else{
        [[UIColor colorWithRed:124.0/255.0 green:192.0/255.0 blue:18.0/255.0 alpha:1.0] set];        
    }    
    [processPath stroke];
    
    progresslabel = [ [UILabel alloc ] initWithFrame:CGRectMake(self.bounds.size.width/2-15, self.bounds.size.height/2-15, 30.0, 30.0) ];
    progresslabel.textAlignment =  UITextAlignmentCenter;
    progresslabel.textColor = [UIColor blackColor];
    progresslabel.backgroundColor = [UIColor clearColor];
    progresslabel.font = [UIFont fontWithName:@"Arial" size:(14.0)];
    [self addSubview:progresslabel];
     //   NSLog(@" %f %@",_progress,styleOfProgress);
    progresslabel.text = [NSString stringWithFormat: @"%d",(int)(roundf(_progress *100))];

}

@end
