//

//

#import <GLKit/GLKit.h>

@class AGLKVertexAttribArrayBuffer;


@interface five_6ViewController : GLKViewController

@property (strong, nonatomic) GLKBaseEffect 
   *baseEffect;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer 
   *vertexPositionBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer 
   *vertexNormalBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer 
   *vertexTextureCoordBuffer;
@property (strong, nonatomic) GLKTextureInfo 
   *earthTextureInfo;
@property (strong, nonatomic) GLKTextureInfo 
   *moonTextureInfo;
@property (nonatomic) GLKMatrixStackRef 
   modelviewMatrixStack;
@property (nonatomic) GLfloat
   earthRotationAngleDegrees;
@property (nonatomic) GLfloat
   moonRotationAngleDegrees;
   
/////////////////////////////////////////////////////////////////
// This method is called by a user interface object configured
// in Interface Builder.
- (IBAction)takeShouldUsePerspectiveFrom:(UISwitch *)aControl;

@end

//@interface Item : UIViewController




//@end