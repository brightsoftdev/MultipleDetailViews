/*
    File:  AVCaptureVideoPreviewLayer.h

	Framework:  AVFoundation
 
	Copyright 2010 Apple Inc. All rights reserved.
*/

#import <AVFoundation/AVBase.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVAnimation.h>

@class AVCaptureVideoPreviewLayerInternal;

/*!
 @class AVCaptureVideoPreviewLayer
 @abstract
	A CoreAnimation layer subclass for previewing the visual output of an AVCaptureSession.

 @discussion		
	An AVCaptureVideoPreviewLayer instance is a subclass of CALayer and is therefore
	suitable for insertion in a layer hierarchy as part of a graphical interface.
	One creates an AVCaptureVideoPreviewLayer instance with the capture session to be
	previewed, using +layerWithSession: or -initWithSession:.  Using the @"videoGravity"
	property, one can influence how content is viewed relative to the layer bounds.  On
	some hardware configurations, the orientation of the layer can be manipulated using
	@"orientation" and @"mirrored".
*/
NS_CLASS_AVAILABLE(10_7, 4_0)
@interface AVCaptureVideoPreviewLayer : CALayer
{
	AVCaptureVideoPreviewLayerInternal *_internal;
}

/*!
 @method layerWithSession:
 @abstract
	Creates an AVCaptureVideoPreviewLayer for previewing the visual output of the
	specified AVCaptureSession.

 @param session
	The AVCaptureSession instance to be previewed.
 @result
	A newly initialized AVCaptureVideoPreviewLayer instance.
*/
+ (id)layerWithSession:(AVCaptureSession *)session;

/*!
 @method initWithSession:
 @abstract
	Creates an AVCaptureVideoPreviewLayer for previewing the visual output of the
	specified AVCaptureSession.

 @param session
	The AVCaptureSession instance to be previewed.
 @result
	A newly initialized AVCaptureVideoPreviewLayer instance.
*/
- (id)initWithSession:(AVCaptureSession *)session;

/*!
 @property session
 @abstract
	The AVCaptureSession instance being previewed by the receiver.

 @discussion
	The session is retained by the preview layer.
*/
@property (nonatomic, retain) AVCaptureSession *session;

/*!
 @property videoGravity
 @abstract
	A string defining how the video is displayed within an AVCaptureVideoPreviewLayer bounds rect.

 @discussion
	Options are AVLayerVideoGravityResize, AVLayerVideoGravityResizeAspect 
	and AVLayerVideoGravityResizeAspectFill. AVLayerVideoGravityResizeAspect is default.
	See <AVFoundation/AVAnimation.h> for a description of these options.
	This property is animatable.
 */
@property (copy) NSString *videoGravity;

/*!
 @property orientationSupported
 @abstract
	Specifies whether or not the preview layer supports orientation.

 @discussion
	Changes in orientation are not supported on all hardware configurations.  An
	application should check the value of @"orientationSupported" before attempting to
	manipulate the orientation of the receiver.
*/
@property (nonatomic, readonly, getter=isOrientationSupported) BOOL orientationSupported;

/*!
 @property orientation
 @abstract
	Specifies the orientation of the preview layer.

 @discussion
	AVCaptureVideoOrientation and its constants are defined in AVCaptureSession.h.
	The value of @"orientationSupported" must be YES in order to set @"orientation".  An
	exception will be raised if this requirement is ignored.
*/
@property (nonatomic) AVCaptureVideoOrientation orientation;

/*!
 @property mirroringSupported
 @abstract
	Specifies whether or not the preview layer supports mirroring.

 @discussion
	Mirroring is not supported on all hardware configurations.  An application should
	check the value of @"mirroringSupported" before attempting to manipulate mirroring
	on the receiver.
*/
@property (nonatomic, readonly, getter=isMirroringSupported) BOOL mirroringSupported;

/*!
 @property automaticallyAdjustsMirroring
 @abstract
	Specifies whether or not the value of @"mirrored" can change based on configuration
	of the session.
	
 @discussion		
	For some session configurations, preview will be mirrored by default.  When the value 
	of this property is YES, the value of @"mirrored" may change depending on the configuration 
	of the session, for example after switching to a different AVCaptureDeviceInput.
	The default value is YES.
*/
@property (nonatomic) BOOL automaticallyAdjustsMirroring;

/*!
 @property mirrored
 @abstract
	Specifies whether or not the preview is flipped over a vertical axis.
	
 @discussion		
	For most applications, it is unnecessary to manipulate preview mirroring manually if 
	@"automaticallyAdjustsMirroring" is set to YES.
	The value of @"automaticallyAdjustsMirroring" must be NO in order to set @"mirrored".
	The value of @"mirroringSupported" must be YES in order to set @"mirrored".  An
	exception will be raised if the value of @"mirrored" is mutated without respecting
	these requirements.
*/
@property (nonatomic, getter=isMirrored) BOOL mirrored;

@end
