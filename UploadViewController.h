//
//  UploadViewController.h
//  LGSideMenuControllerDemo
//
//  Created by Vivek Tyagi on 6/3/19.
//  Copyright © 2019 Grigory Lutkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GTLRYouTube.h>
#import <Google/SignIn.h>
#import <GTLRUploadParameters.h>
#import <GoogleAPIClientForREST/GTLRYouTubeObjects.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <GoogleAPIClientForREST/GTLRUtilities.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <GTMSessionFetcher/GTMSessionUploadFetcher.h>
#import <GoogleAPIClientForREST/GTLRYouTubeService.h>
//#import <GTMSessionFetcher/GTMSessionFetcherLogging.h>
#import <GoogleAPIClientForREST/GTLRYouTubeQuery.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadViewController : UIViewController <UIWebViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GIDSignInDelegate, GIDSignInUIDelegate>{
    NSString *youTubeVideoHTML;
    
    IBOutlet UIWebView *loadYoutubeURLInWebV;
    
    IBOutlet UIButton *_uploadPrivacyPopup;
    IBOutlet UITextField *_uploadTitleField;
    IBOutlet UITextField *_uploadPathField;
    UIActivityIndicatorView *spinner;
    IBOutlet UIButton *_uploadButton;
    IBOutlet UIButton *_pauseUploadButton;
    IBOutlet UIButton *_stopUploadButton;
    IBOutlet UIButton *_restartUploadButton;
    
    IBOutlet UITextField *_clientIDRequiredTextField;
    IBOutlet UITextField *_clientIDField;
    IBOutlet UITextField *_clientSecretField;
    IBOutlet UIImageView *_thumbnailView;

    GTLRServiceTicket *_uploadFileTicket;
    NSURL *_uploadLocationURL;  // URL for restarting an upload.
//    OIDRedirectHTTPHandler *_redirectHTTPHandler;

    IBOutlet UITextView *_playlistResultTextField;
}

@property (nonatomic, strong) NSString *getVideoID;
@property (strong, nonatomic) NSURL *videoURL;
//@property (strong, nonatomic) MPMoviePlayerController *videoController;
//@property (nonatomic, readonly) GTLRYouTubeService *youTubeService;

@property (nonatomic, strong) IBOutlet GIDSignInButton *signInButton;
@property (nonatomic, strong) UITextView *output;
@property (nonatomic, strong) GTLRYouTubeService *service;
//@property (nonatomic, strong) GTLRYouTubeObjects *youtubeObjects;

- (IBAction)captureVideo:(id)sender;

@end

NS_ASSUME_NONNULL_END
