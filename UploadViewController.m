//
//  UploadViewController.m
//  LGSideMenuControllerDemo
//
//  Created by Vivek Tyagi on 6/3/19.
//  Copyright © 2019 Grigory Lutkov. All rights reserved.
//

#import "UploadViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface UploadViewController ()

@property (strong) NSString* videoPath;
//@property (strong) GTLRServiceTicket *uploadFileTicket;


@end

@implementation UploadViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"UPLOAD VIDEO";
    }

    return self;
}

- (void) viewDidLoad{
    
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.delegate = self;
    signIn.uiDelegate = self;
    signIn.scopes = [NSArray arrayWithObjects:kGTLRAuthScopeYouTubeUpload, kGTLRAuthScopeYouTube,kGTLRAuthScopeYouTubeForceSsl, kGTLRAuthScopeYouTubeReadonly, kGTLRAuthScopeYouTubeYoutubepartner, kGTLRAuthScopeYouTubeYoutubepartnerChannelAudit, nil];
    
    if ([signIn hasAuthInKeychain] == true) {
        [signIn signInSilently];
    }else{
        [signIn signIn];
    }
    
    // Add the sign-in button.
    self.signInButton = [[GIDSignInButton alloc] init];
    [self.view addSubview:self.signInButton];
    
    // Create a UITextView to display output.
    self.output = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.output.editable = false;
    self.output.contentInset = UIEdgeInsetsMake(20.0, 0.0, 20.0, 0.0);
    self.output.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.output.hidden = true;
    [self.view addSubview:self.output];
    
    // Initialize the service object.
    self.service = [[GTLRYouTubeService alloc] init];
    
    UIImage* slideImg = [UIImage imageNamed:@"backIcon"];
    CGRect setFrameslideImg = CGRectMake(0, 0, slideImg.size.width, slideImg.size.height);
    UIButton *setSliderButtonImg = [[UIButton alloc] initWithFrame:setFrameslideImg];
    [setSliderButtonImg setBackgroundImage:slideImg forState:UIControlStateNormal];
    [setSliderButtonImg addTarget:self action:@selector(goToPrvsScreen)
                 forControlEvents:UIControlEventTouchUpInside];
    [setSliderButtonImg setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *setSliderBarBtnItem =[[UIBarButtonItem alloc] initWithCustomView:setSliderButtonImg];
    self.navigationItem.leftBarButtonItem=setSliderBarBtnItem;
    
    //    [self playVideoWithId:_getVideoID];
}
//
//

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error != nil) {
        [self showAlert:@"Authentication Error" message:error.localizedDescription];
        self.service.authorizer = nil;
    } else {
        self.signInButton.hidden = true;
        self.output.hidden = false;
        self.service.authorizer = user.authentication.fetcherAuthorizer;
        self.service.APIKey = @"AIzaSyB-qRkzNjhVuZKj7e-ljb4EF1624BDj5uY";
//        [self fetchChannelResource];
        
        [self captureVideo:self];
    }
}

// Helper for showing an alert
- (void)showAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
     {
         [alert dismissViewControllerAnimated:YES completion:nil];
     }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}


//- (void) viewWillAppear:(BOOL)animated{
//
//    GIDSignIn* signIn = [GIDSignIn sharedInstance];
//    signIn.delegate = self;
//    signIn.uiDelegate = self;
////    [signIn hasAuthInKeychain];
//    signIn.scopes = [NSArray arrayWithObjects:kGTLRAuthScopeYouTubeUpload, nil];
//
//    if ([signIn hasAuthInKeychain] == true) {
//        [signIn signInSilently];
//    }else{
//        [signIn signIn];
//    }
//
//    // Add the sign-in button.
//    self.signInButton = [[GIDSignInButton alloc] init];
//    [self.view addSubview:self.signInButton];
//
//    // Create a UITextView to display output.
//    self.output = [[UITextView alloc] initWithFrame:self.view.bounds];
//    self.output.editable = false;
//    self.output.contentInset = UIEdgeInsetsMake(20.0, 0.0, 20.0, 0.0);
//    self.output.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.output.hidden = true;
//    [self.view addSubview:self.output];
//
//    // Initialize the service object.
//    self.service = [[GTLRYouTubeService alloc] init];
//
//    UIImage* slideImg = [UIImage imageNamed:@"backIcon"];
//    CGRect setFrameslideImg = CGRectMake(0, 0, slideImg.size.width, slideImg.size.height);
//    UIButton *setSliderButtonImg = [[UIButton alloc] initWithFrame:setFrameslideImg];
//    [setSliderButtonImg setBackgroundImage:slideImg forState:UIControlStateNormal];
//    [setSliderButtonImg addTarget:self action:@selector(goToPrvsScreen)
//                 forControlEvents:UIControlEventTouchUpInside];
//    [setSliderButtonImg setShowsTouchWhenHighlighted:YES];
//
//    UIBarButtonItem *setSliderBarBtnItem =[[UIBarButtonItem alloc] initWithCustomView:setSliderButtonImg];
//    self.navigationItem.leftBarButtonItem=setSliderBarBtnItem;
//
////    [self playVideoWithId:_getVideoID];
//}


- (IBAction)captureVideo:(id)sender
//{
////    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
////    imagePicker.delegate = self;
////    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
////    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage ,nil];
////    //(NSString *)kUTTypeMovie,      (NSString *)kUTTypeVideo,
////
////    [self presentViewController:imagePicker animated:YES completion:^{
////
////    }];
//
//    // Present videos from which to choose
//    UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
//    videoPicker.delegate = self; // ensure you set the delegate so when a video is chosen the right method can be called
//
//    videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
//    // This code ensures only videos are shown to the end user
//    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
//
//    videoPicker.videoQuality = UIImagePickerControllerQualityTypeLow;
//    [self presentViewController:videoPicker animated:YES completion:nil];
//}



{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];

//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//
//        //        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, kUTTypeVideo, nil];
//
//        [self presentViewController:picker animated:YES completion:NULL];
//    }
//    else{
        ////        picker.delegate = self;
        ////        picker.allowsEditing = YES;
        ////        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ////        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        ////
        ////        [self presentViewController:picker animated:YES completion:NULL];
        //
        //        picker.delegate = self;
        //
        //        //        picker.allowsEditing = YES;
        //
        //        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //        picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
        //        [self presentViewController:picker animated:YES completion:^{
        //
        //        }];

        // Present videos from which to choose
        UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
        videoPicker.delegate = self; // ensure you set the delegate so when a video is chosen the right method can be called

        videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
        videoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // This code ensures only videos are shown to the end user
        videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
        videoPicker.allowsEditing = YES;
        [videoPicker setVideoMaximumDuration:20.0f];
        videoPicker.videoQuality = UIImagePickerControllerQualityTypeLow;
        [self presentViewController:videoPicker animated:YES completion:nil];
//    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    // This is the NSURL of the video object
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];

    NSLog(@"VideoURL = %@", videoURL);

//    if (![self isSignedIn]) {
//        // Sign in.
//        [self runSigninThenHandler:^{
//            [self updateUI];
//        }];
//    } else {
//        // Sign out.
//        GTLRYouTubeService *service = self.youTubeService;
//
//        [GTMAppAuthFetcherAuthorization
//         removeAuthorizationFromKeychainForName:kGTMAppAuthKeychainItemName];
//        service.authorizer = nil;
//        [self updateUI];
//    }

    [self uploadVideoFile:videoURL];
//
//
//    GTLRYouTube_VideoStatus *status = [GTLRYouTube_VideoStatus object];
//    status.privacyStatus = @"public";
//
//    GTLRYouTube_VideoSnippet *snippet = [GTLRYouTube_VideoSnippet object];
//    snippet.channelId = @"UC2piC7eXPns9YXoto2R5JnQ";
//    snippet.title = @"test Video dated July 13"; //self.mTitleField
//    snippet.descriptionProperty = @"test vieo needs description too dummy"; //self.mDescriptionField
//
//    GTLRYouTube_Video *video = [GTLRYouTube_Video object];
//    video.status = status;
//    video.snippet = snippet;
//
//    GTLRUploadParameters *uploadParameters = [GTLRUploadParameters uploadParametersWithFileURL:videoURL MIMEType:@"video/*"];
//                                               //alloc] init];
////    uploadParameters.fileURL = videoURL;
////    uploadParameters.MIMEType = @"video/*";
//
//
//    NSString *mediaType1 = [info objectForKey: UIImagePickerControllerMediaType];
//    NSString *moviePath;
//
//    // Handle a movie capture
//    if (CFStringCompare ((CFStringRef) mediaType1, kUTTypeMovie, 0) == kCFCompareEqualTo)
//    {
//        [self dismissViewControllerAnimated:YES completion:Nil];
//        moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
//
//        NSURL *fileToUploadURL = [NSURL fileURLWithPath:videoURL.absoluteString];
//
//        uploadParameters.uploadLocationURL = videoURL; //fileToUploadURL
//    }
//
//
//    GTLRYouTubeQuery_VideosInsert *query =
//    [GTLRYouTubeQuery_VideosInsert queryWithObject:video
//                                              part:@"snippet,status"
//                                  uploadParameters:uploadParameters];
//
////    [self.mProgressView setProgress: 0.0];
//
//    query.executionParameters.uploadProgressBlock = ^(GTLRServiceTicket *ticket,
//                                                      unsigned long long numberOfBytesRead,
//                                                      unsigned long long dataLength) {
//        NSLog(@"Bytes read %f", (double)numberOfBytesRead);
////        [self.mProgressView setProgress: (1.0 / (double)dataLength) * (double)numberOfBytesRead];
//    };
    
    NSLog(@"YT-Service %@", self.service.authorizer); // Returns not null
    
//    _uploadFileTicket = [self.service executeQuery:query
//                                        completionHandler:^(GTLRServiceTicket *callbackTicket,
//                                                            GTLRYouTube_Video *uploadedVideo,
//                                                            NSError *callbackError) {
//                                            // Callback
//                                            _uploadFileTicket = nil;
//                                            if (callbackError == nil) {
//                                                [picker dismissViewControllerAnimated:YES completion:^{
//                                                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Uploaded" message:@"Your video has been uploaded to YouTube Channel." preferredStyle:UIAlertControllerStyleAlert];
//                                                    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//                                                    [alert addAction:okButton];
//                                                    [self presentViewController:alert animated:YES completion:nil];
//                                                }];
//                                            } else {
//
//                                                NSLog(@"callbackError.localizedDescription: %@", callbackError.localizedDescription);
//
//                                                [picker dismissViewControllerAnimated:YES completion:^{
//                                                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Upload failed" message:[NSString stringWithFormat:@"%@", callbackError.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
//                                                    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                                                        [self goToPrvsScreen];
//                                                    }];
//                                                    [alert addAction:okButton];
//                                                    [self presentViewController:alert animated:YES completion:^{
//                                                    }];
//                                                }];
//                                            }
//
////                                            self.isUploading = NO;
////                                            [self.mProgressView setProgress: 0.0];
//
//                                        }];
}
//
//- (NSString *)signedInUsername {
//    // Get the email address of the signed-in user.
//    id<GTMFetcherAuthorizationProtocol> auth = self.youTubeService.authorizer;
//    BOOL isSignedIn = auth.canAuthorize;
//    if (isSignedIn) {
//        return auth.userEmail;
//    } else {
//        return nil;
//    }
//}
//
//- (BOOL)isSignedIn {
//    NSString *name = [self signedInUsername];
//    return (name != nil);
//}
//
//
//- (void)runSigninThenHandler:(void (^)(void))handler {
//    // Applications should have client ID hardcoded into the source
//    // but the sample application asks the developer for the strings.
//    // Client secret is now left blank.
//    NSString *clientID = @"117039992021-52ur1bfkjripb6621cllcg5fmsors9ef.apps.googleusercontent.com"; //clientID
//    NSString *clientSecret = @"6rM0IT2r2iKvLJjVm7Kcnb0i"; //ReverseKey
//
////    if (clientID.length == 0) {
////        // Remind the developer that client ID is needed. Client secret is now left blank
////        [_clientIDButton performSelector:@selector(performClick:)
////                              withObject:self
////                              afterDelay:0.5];
////        return;
////    }
//
////    NSURL *successURL = [NSURL URLWithString:kSuccessURLString];
//
//    // Starts a loopback HTTP listener to receive the code, gets the redirect URI to be used.
////    _redirectHTTPHandler = [[OIDRedirectHTTPHandler alloc] initWithSuccessURL:successURL];
////    NSError *error;
////    NSURL *localRedirectURI = [_redirectHTTPHandler startHTTPListener:&error];
////    if (!localRedirectURI) {
////        NSLog(@"Unexpected error starting redirect handler %@", error);
////        return;
////    }
//
//    // Builds authentication request.
//    OIDServiceConfiguration *configuration =
//    [GTMAppAuthFetcherAuthorization configurationForGoogle];
//    NSArray<NSString *> *scopes = @[ kGTLRAuthScopeYouTube, OIDScopeEmail ];
//    OIDAuthorizationRequest *request =
//    [[OIDAuthorizationRequest alloc] initWithConfiguration:configuration
//                                                  clientId:clientID
//                                              clientSecret:clientSecret
//                                                    scopes:scopes
//                                               redirectURL:localRedirectURI
//                                              responseType:OIDResponseTypeCode
//                                      additionalParameters:nil];
//
//    // performs authentication request
//    __weak __typeof(self) weakSelf = self;
//    _redirectHTTPHandler.currentAuthorizationFlow =
//    [OIDAuthState authStateByPresentingAuthorizationRequest:request
//                                                   callback:^(OIDAuthState *_Nullable authState,
//                                                              NSError *_Nullable error) {
//                                                       // Using weakSelf/strongSelf pattern to avoid retaining self as block execution is indeterminate
//                                                       __strong __typeof(weakSelf) strongSelf = weakSelf;
//                                                       if (!strongSelf) {
//                                                           return;
//                                                       }
//
//                                                       // Brings this app to the foreground.
//                                                       [[NSRunningApplication currentApplication]
//                                                        activateWithOptions:(NSApplicationActivateAllWindows |
//                                                                             NSApplicationActivateIgnoringOtherApps)];
//
//                                                       if (authState) {
//                                                           // Creates a GTMAppAuthFetcherAuthorization object for authorizing requests.
//                                                           GTMAppAuthFetcherAuthorization *gtmAuthorization =
//                                                           [[GTMAppAuthFetcherAuthorization alloc] initWithAuthState:authState];
//
//                                                           // Sets the authorizer on the GTLRYouTubeService object so API calls will be authenticated.
//                                                           strongSelf.youTubeService.authorizer = gtmAuthorization;
//
//                                                           // Serializes authorization to keychain in GTMAppAuth format.
//                                                           [GTMAppAuthFetcherAuthorization saveAuthorization:gtmAuthorization
//                                                                                           toKeychainForName:kGTMAppAuthKeychainItemName];
//
//                                                           // Executes post sign-in handler.
//                                                           if (handler) handler();
//                                                       } else {
//                                                           strongSelf->_channelListFetchError = error;
//                                                           [strongSelf updateUI];
//                                                       }
//                                                   }];
//}
//
- (void)goToPrvsScreen {
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}
//
////- (void)playVideoWithId:(NSString *)videoId {
////
////    youTubeVideoHTML = @"<!DOCTYPE html><html><head><style>body{margin:0px 0px 0px 0px;}</style></head> <body> <div id=\"player\"></div> <script> var tag = document.createElement('script'); tag.src = \"http://www.youtube.com/player_api\"; var firstScriptTag = document.getElementsByTagName('script')[0]; firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); var player; function onYouTubePlayerAPIReady() { player = new YT.Player('player', { width:'%0.0f', height:'%0.0f', videoId:'%@', events: { 'onReady': onPlayerReady, } }); } function onPlayerReady(event) { event.target.playVideo(); } </script> </body> </html>";
////
////    loadYoutubeURLInWebV.allowsInlineMediaPlayback = true;
////    loadYoutubeURLInWebV.mediaPlaybackRequiresUserAction = true;
////
////    NSString *html = [NSString stringWithFormat:youTubeVideoHTML, self.view.frame.size.width, self.view.frame.size.height, @"pzosICbwa8A"];
////
////    [loadYoutubeURLInWebV loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
////}
//
////- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
////
////    // This is the NSURL of the video object
////    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
////
////    NSLog(@"VideoURL = %@", videoURL);
////    [picker dismissViewControllerAnimated:YES completion:NULL];
////}
//
//
////- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//////    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
//////
//////    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
//////        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
//////        NSString *moviePath = [videoUrl path];
//////
//////        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
//////            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
//////        }
//////    }
////
////    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
////    //NSLog(@"type=%@",type);
////    if ([type isEqualToString:(NSString *)kUTTypeImage])
////        //[type isEqualToString:(NSString *)kUTTypeVideo] ||
////        //[type isEqualToString:(NSString *)kUTTypeMovie])
////    {// movie != video
////        NSURL *urlvideo =[info objectForKey:@"UIImagePickerControllerImageURL"];
////        //[info objectForKey:UIImagePickerControllerMediaURL];
////
////        NSString *moviePath = [urlvideo path];
////
////        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
////            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
////        }
////
////    }
////
////    [self dismissViewControllerAnimated:YES completion:^{
////
////    }];
////}
//
////- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
////{
////    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
////
////    // Handle a movie capture
////    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
////    {
////        [self dismissViewControllerAnimated:YES completion:Nil];
////        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
////
////        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath))
////        {
////            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self,@selector(video:didFinishSavingWithError:contextInfo:), nil);
////        }
////    }
////}
//
//-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
//{
//    if (error)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
//                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
//                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//}
//
////- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
////
////    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
////
////    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
////    {
////
////        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
////        NSString *urlPath = [videoURL path];
////
////        if ([[urlPath lastPathComponent] isEqualToString:@"capturedvideo.MOV"])
////        {
////            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (urlPath))
////            {
////                [self copyTempVideoToMediaLibrary :urlPath];
////
////
////            }
////            else
////            {
////                NSLog(@"Video Capture Error: Captured video cannot be saved...didFinishPickingMediaWithInfo()");
////            }
////        }
////        else
////        {
////            NSLog(@"Processing soon to saved photos album...else loop of lastPathComponent..didFinishPickingMediaWithInfo()");
////        }
////    }
////
////
////    self.videoURL = info[UIImagePickerControllerMediaURL];
//////    [picker dismissViewControllerAnimated:YES completion:NULL];
////
////    self.videoController = [[MPMoviePlayerController alloc] init];
////
////    [self.videoController setContentURL:self.videoURL];
////    [self.videoController.view setFrame:CGRectMake (0, 0, self.view.frame.size.width, 460)];
////    [self.view addSubview:self.videoController.view];
////
////    [[NSNotificationCenter defaultCenter] addObserver:self
////                                             selector:@selector(videoPlayBackDidFinish:)
////                                                 name:MPMoviePlayerPlaybackDidFinishNotification
////                                               object:self.videoController];
////    [self.videoController play];
////
////}
//
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:^{
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
}
//
//- (void)videoPlayBackDidFinish:(NSNotification *)notification {
//
////    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
//
//    // Stop the video player and remove it from view
////    [self.videoController stop];
////    [self.videoController.view removeFromSuperview];
////    self.videoController = nil;
//
//    // Display a message
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Video Playback" message:@"Just finished the video playback. The video is now removed." preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:okayAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//
//}
//
//- (void)copyTempVideoToMediaLibrary :(NSString *)videoURL {
//
//    dispatch_queue_t mainQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_async(mainQueue, ^{
//
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//
//        ALAssetsLibraryWriteVideoCompletionBlock completionBlock = ^(NSURL *assetURL, NSError *error) {
//            NSLog(@"Saved URL: %@", assetURL);
//            NSLog(@"Error: %@", error);
//
//            if (assetURL != nil) {
//
//                AVURLAsset *theAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:videoURL] options:nil];
//
//                NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:theAsset];
//
//                AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:theAsset presetName:AVAssetExportPresetLowQuality];
//
//                [exportSession setOutputURL:[NSURL URLWithString:videoURL]];
//                [exportSession setOutputFileType:AVFileTypeQuickTimeMovie];
//
//                [exportSession exportAsynchronouslyWithCompletionHandler:^ {
//                    switch ([exportSession status]) {
//                        case AVAssetExportSessionStatusFailed:
//                            NSLog(@"Export session faied with error: %@", [exportSession error]);
//                            break;
//                        default:
//                            //[self mediaIsReady];
//                            break;
//                    }
//                }];
//            }
//        };
//
//        [library writeVideoAtPathToSavedPhotosAlbum:[NSURL URLWithString:videoURL] completionBlock:completionBlock];
//    });
//}
//
///*
//
// NSDictionary *settings = @{AVVideoCodecKey:AVVideoCodecH264,
// AVVideoWidthKey:@(video_width),
// AVVideoHeightKey:@(video_height),
// AVVideoCompressionPropertiesKey:
// @{AVVideoAverageBitRateKey:@(desired_bitrate),
// AVVideoProfileLevelKey:AVVideoProfileLevelH264Main31,
// // Or whatever profile & level you wish to use
//
//
// // For responding to the user accepting a newly-captured picture or movie
// - (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
//
// // Handle movie capture
// NSURL *movieURL = [info objectForKey:
// UIImagePickerControllerMediaURL];
//
// NSURL *uploadURL = [NSURL fileURLWithPath:[[NSTemporaryDirectory() stringByAppendingPathComponent:[self randomString]] stringByAppendingString:@".mp4"]];
//
// // Compress movie first
// [self convertVideoToLowQuailtyWithInputURL:movieURL outputURL:uploadURL];
// }
//
//
// AVVideoMaxKeyFrameIntervalKey:@(desired_keyframe_interval)}};
//
// AVAssetWriterInput* writer_input = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:settings];
//
// - (void)convertVideoToLowQuailtyWithInputURL:(NSURL*)inputURL
// outputURL:(NSURL*)outputURL
// {
// //setup video writer
// AVAsset *videoAsset = [[AVURLAsset alloc] initWithURL:inputURL options:nil];
//
// AVAssetTrack *videoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
//
// CGSize videoSize = videoTrack.naturalSize;
//
// NSDictionary *videoWriterCompressionSettings =  [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1250000], AVVideoAverageBitRateKey, nil];
//
// NSDictionary *videoWriterSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey, videoWriterCompressionSettings, AVVideoCompressionPropertiesKey, [NSNumber numberWithFloat:videoSize.width], AVVideoWidthKey, [NSNumber numberWithFloat:videoSize.height], AVVideoHeightKey, nil];
//
// AVAssetWriterInput* videoWriterInput = [AVAssetWriterInput
// assetWriterInputWithMediaType:AVMediaTypeVideo
// outputSettings:videoWriterSettings];
//
// videoWriterInput.expectsMediaDataInRealTime = YES;
//
// videoWriterInput.transform = videoTrack.preferredTransform;
//
// AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:outputURL fileType:AVFileTypeQuickTimeMovie error:nil];
//
// [videoWriter addInput:videoWriterInput];
//
// //setup video reader
// NSDictionary *videoReaderSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
//
// AVAssetReaderTrackOutput *videoReaderOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:videoTrack outputSettings:videoReaderSettings];
//
// AVAssetReader *videoReader = [[AVAssetReader alloc] initWithAsset:videoAsset error:nil];
//
// [videoReader addOutput:videoReaderOutput];
//
// //setup audio writer
// AVAssetWriterInput* audioWriterInput = [AVAssetWriterInput
// assetWriterInputWithMediaType:AVMediaTypeAudio
// outputSettings:nil];
//
// audioWriterInput.expectsMediaDataInRealTime = NO;
//
// [videoWriter addInput:audioWriterInput];
//
// //setup audio reader
// AVAssetTrack* audioTrack = [[videoAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
//
// AVAssetReaderOutput *audioReaderOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:audioTrack outputSettings:nil];
//
// AVAssetReader *audioReader = [AVAssetReader assetReaderWithAsset:videoAsset error:nil];
//
// [audioReader addOutput:audioReaderOutput];
//
// [videoWriter startWriting];
//
// //start writing from video reader
// [videoReader startReading];
//
// [videoWriter startSessionAtSourceTime:kCMTimeZero];
//
// dispatch_queue_t processingQueue = dispatch_queue_create("processingQueue1", NULL);
//
// [videoWriterInput requestMediaDataWhenReadyOnQueue:processingQueue usingBlock:
// ^{
//
// while ([videoWriterInput isReadyForMoreMediaData]) {
//
// CMSampleBufferRef sampleBuffer;
//
// if ([videoReader status] == AVAssetReaderStatusReading &&
// (sampleBuffer = [videoReaderOutput copyNextSampleBuffer])) {
//
// [videoWriterInput appendSampleBuffer:sampleBuffer];
// CFRelease(sampleBuffer);
// }
//
// else {
//
// [videoWriterInput markAsFinished];
//
// if ([videoReader status] == AVAssetReaderStatusCompleted) {
//
// //start writing from audio reader
// [audioReader startReading];
//
// [videoWriter startSessionAtSourceTime:kCMTimeZero];
//
// dispatch_queue_t processingQueue = dispatch_queue_create("processingQueue2", NULL);
//
// [audioWriterInput requestMediaDataWhenReadyOnQueue:processingQueue usingBlock:^{
//
// while (audioWriterInput.readyForMoreMediaData) {
//
// CMSampleBufferRef sampleBuffer;
//
// if ([audioReader status] == AVAssetReaderStatusReading &&
// (sampleBuffer = [audioReaderOutput copyNextSampleBuffer])) {
//
// [audioWriterInput appendSampleBuffer:sampleBuffer];
// CFRelease(sampleBuffer);
// }
//
// else {
//
// [audioWriterInput markAsFinished];
//
// if ([audioReader status] == AVAssetReaderStatusCompleted) {
//
// [videoWriter finishWritingWithCompletionHandler:^(){
// [self sendMovieFileAtURL:outputURL];
// }];
//
// }
// }
// }
//
// }
// ];
// }
// }
// }
// }
// ];
// }
// */
//
//#pragma mark - Upload
//
- (void)uploadVideoFile :(NSURL *)setURLPath {
    // Collect the metadata for the upload from the user interface.

    // Status.
    GTLRYouTube_VideoStatus *status = [GTLRYouTube_VideoStatus object];
    status.privacyStatus = @"private";//_uploadPrivacyPopup.titleLabel;

    // Snippet.
    GTLRYouTube_VideoSnippet *snippet = [GTLRYouTube_VideoSnippet object];
    snippet.title = @"titleTest";//_uploadTitleField.stringValue
    NSString *desc = @"DescriptionTest";//_uploadDescriptionField.stringValue
    if (desc.length > 0) {
        snippet.descriptionProperty = desc;
    }
//    NSString *tagsStr = _uploadTagsField.stringValue;
//    if (tagsStr.length > 0) {
//        snippet.tags = [tagsStr componentsSeparatedByString:@","];
//    }
//    if ([_uploadCategoryPopup isEnabled]) {
//        NSMenuItem *selectedCategory = _uploadCategoryPopup.selectedItem;
//        snippet.categoryId = selectedCategory.representedObject;
//    }

    GTLRYouTube_Video *video = [GTLRYouTube_Video object];
    video.status = status;
    video.snippet = snippet;

//    [self uploadVideoWithVideoObject:video
//             resumeUploadLocationURL:nil];
    
    [self uploadVideoWithVideoObject:video
             resumeUploadLocationURL:setURLPath];
}
//
//- (void)uploadVideoWithVideoObject:(GTLRYouTube_Video *)video
//           resumeUploadLocationURL:(NSURL *)locationURL {
//    NSURL *fileToUploadURL = locationURL;
//    //[NSURL fileURLWithPath:locationURL]; // PATH HERE //_uploadPathField.text
//    NSError *fileError;
//    if (![fileToUploadURL checkPromisedItemIsReachableAndReturnError:&fileError]) {
//        [self displayAlert:@"No Upload File Found"
//                    format:@"Path: %@", fileToUploadURL.path];
//        return;
//    }
//
//    // Get a file handle for the upload data.
//    NSString *filename = [fileToUploadURL lastPathComponent];
//    NSString *mimeType = [self MIMETypeForFilename:filename
//                                   defaultMIMEType:@"video/*"]; //video/mp4
//    GTLRUploadParameters *uploadParameters =
//    [GTLRUploadParameters uploadParametersWithFileURL:fileToUploadURL
//                                             MIMEType:mimeType];
//    uploadParameters.uploadLocationURL = locationURL;
//
//
////    GTMSessionFetcher *fetcher = [self.service.fetcherService fetcherWithURL:locationURL];
////    fetcher.authorizer = self.service.authorizer;
////    fetcher.allowLocalhostRequest = YES;
//
//    GTLRYouTubeQuery_VideosInsert *query =
//    [GTLRYouTubeQuery_VideosInsert queryWithObject:video
//                                              part:@"snippet,status"
//                                  uploadParameters:uploadParameters];
//
//
////     spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
////
////     spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 40, 40);
////
////     spinner.center = self.view.center;
////
////     [self.view addSubview:spinner];
////
////     [spinner startAnimating];
////
//
////    NSProgressIndicator *progressIndicator = _uploadProgressIndicator;
//
//    query.executionParameters.uploadProgressBlock = ^(GTLRServiceTicket *ticket,
//                                                      unsigned long long numberOfBytesRead,
//                                                      unsigned long long dataLength) {
////        progressIndicator.maxValue = (double)dataLength;
////        progressIndicator.doubleValue = (double)numberOfBytesRead;
//    };
//
//    GTLRYouTubeService *service = self.service;
//    _uploadFileTicket = [service executeQuery:query
//                            completionHandler:^(GTLRServiceTicket *callbackTicket,
//                                                GTLRYouTube_Video *uploadedVideo,
//                                                NSError *callbackError) {
//                                // Callback
//                                self->_uploadFileTicket = nil;
//                                if (callbackError == nil) {
//                                    [self displayAlert:@"Uploaded"
//                                                format:@"Uploaded file \"%@\"",
//                                     uploadedVideo.snippet.title];
//
////                                    if (self->_playlistPopup.selectedTag == kUploadsTag) {
////                                        // Refresh the displayed uploads playlist.
////                                        [self fetchSelectedPlaylist];
////                                    }
//                                } else {
//                                    NSLog(@"callbackError: %@", callbackError);
//
//                                    [self displayAlert:@"Upload Failed"
//                                                format:@"%@", callbackError];
//                                }
//
////                                self->_uploadProgressIndicator.doubleValue = 0.0;
//                                self->_uploadLocationURL = nil;
//                                [self updateUI];
//                            }];
//
//    [self updateUI];
//}
//


- (void)uploadVideoWithVideoObject:(GTLRYouTube_Video *)video
           resumeUploadLocationURL:(NSURL *)locationURL {
    // Get a file handle for the upload data.

    _videoPath = [locationURL path];//[locationURL absoluteString];
    
    NSString *path = _videoPath;
    NSString *filename = [path lastPathComponent];
//    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    if(fileHandle == nil) {
        
        NSLog(@"YouTube Helper: invalid/missing file at location provided %@", path);

        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:path];
    }else {
        [fileHandle seekToEndOfFile];
        
        NSString *mimeType = [self MIMETypeForFilename:filename
                                       defaultMIMEType:@"video/mp4"];
        //        GTLUploadParameters *uploadParameters =
        //        [GTLUploadParameters uploadParametersWithFileHandle:fileHandle
        //                                                   MIMEType:mimeType];
        //        uploadParameters.uploadLocationURL = locationURL;
        
        GTLRUploadParameters *uploadParameters =
        [GTLRUploadParameters uploadParametersWithFileHandle:fileHandle
                                                    MIMEType:mimeType];
        uploadParameters.uploadLocationURL = locationURL;
        
        //        GTLRYouTubeQuery *query = [GTLRYouTubeQuery queryForVideosInsertWithObject:video part:@"snippet,status" uploadParameters:uploadParameters];
        
        GTLRYouTubeQuery_VideosInsert *query =
        [GTLRYouTubeQuery_VideosInsert queryWithObject:video
                                                  part:@"snippet,status"
                                      uploadParameters:uploadParameters];
        
        GTLRYouTubeService *service = self.service;
        
        _uploadFileTicket = [service executeQuery:query
                                     completionHandler:^(GTLRServiceTicket *ticket,
                                                         GTLRYouTube_Video *uploadedVideo,
                                                         NSError *error) {
                                         // Callback
                                         _uploadFileTicket = nil;
                                         if (error == nil) {
                                             NSLog(@"Video Uploaded : %@", uploadedVideo.snippet.title);
                                             
                                         } else {
                                             NSLog(@"Video Upload failed : %@", [error description]);
                                         }
                                     }];
        
//        __weak YouTubeHelper *dummySelf = self;
        
        query.executionParameters.uploadProgressBlock= ^(GTLRServiceTicket *ticket,
                                                         unsigned long long numberOfBytesRead,
                                                         unsigned long long dataLength) {
            
            long double division = (double)numberOfBytesRead / (double)dataLength;
            int percentage = division * 100;
            
//            if (dummySelf.delegate && [dummySelf.delegate respondsToSelector:@selector(uploadProgressPercentage:)]) {
//                [self.delegate uploadProgressPercentage:percentage];
//            }
        };
        
        // To allow restarting after stopping, we need to track the upload location
        // URL.
        //
        // For compatibility with systems that do not support Objective-C blocks
        // (iOS 3 and Mac OS X 10.5), the location URL may also be obtained in the
        // progress callback as ((GTMHTTPUploadFetcher *)[ticket objectFetcher]).locationURL
        
        //        GTMHTTPUploadFetcher *uploadFetcher = (GTMHTTPUploadFetcher *)[_uploadFileTicket objectFetcher];
        //        uploadFetcher.locationChangeBlock = ^(NSURL *url) {
        //            _uploadLocationURL = url;
        //            [self updateUI];
        //        };
    }
}

- (NSString *)MIMETypeForFilename:(NSString *)filename
                  defaultMIMEType:(NSString *)defaultType {
    NSString *result = defaultType;
    NSString *extension = [filename pathExtension];
    CFStringRef uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                            (__bridge CFStringRef)extension, NULL);
    if (uti) {
        CFStringRef cfMIMEType = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType);
        if (cfMIMEType) {
            result = CFBridgingRelease(cfMIMEType);
        }
        CFRelease(uti);
    }
    return result;
}
//
- (void)displayAlert:(NSString *)title format:(NSString *)format, ... {
    NSString *result = format;
    if (format) {
        va_list argList;
        va_start(argList, format);
        result = [[NSString alloc] initWithFormat:format
                                        arguments:argList];
        va_end(argList);
    }
//    NSAlert *alert = [[NSAlert alloc] init];
//    alert.messageText = title;
//    alert.informativeText = result;
//    [alert beginSheetModalForWindow:self.window
//                  completionHandler:nil];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:result
                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
//
//
- (void)updateUI {
//    BOOL isSignedIn = [self isSignedIn];
//    NSString *username = [self signedInUsername];
//    _signedInButton.title = (isSignedIn ? @"Sign Out" : @"Sign In");
//    _signedInField.stringValue = (isSignedIn ? username : @"No");
//
//    //
//    // Playlist table.
//    //
//    [_playlistItemTable reloadData];

//    BOOL isFetchingPlaylist = (_channelListTicket != nil || _playlistItemListTicket != nil);
//    if (isFetchingPlaylist) {
//        [_playlistProgressIndicator startAnimation:self];
//    } else {
//        [_playlistProgressIndicator stopAnimation:self];
//    }
//
    // Get the description of the selected item, or the feed fetch error
    NSString *resultStr = @"";
    NSError *error;
//
//    if (_channelListFetchError) {
//        error = _channelListFetchError;
//    } else {
//        error = _playlistFetchError;
//    }

    if (error) {
        // Display the error.
        resultStr = [error description];

        // Also display any server data present
        NSDictionary *errorInfo = [error userInfo];
        NSData *errData = errorInfo[kGTMSessionFetcherStatusDataKey];
        if (errData) {
            NSString *dataStr = [[NSString alloc] initWithData:errData
                                                      encoding:NSUTF8StringEncoding];
            resultStr = [resultStr stringByAppendingFormat:@"\n%@", dataStr];
        }
    } else {
        // Display the selected item.
//        GTLRYouTube_PlaylistItem *item = [self selectedPlaylistItem];
//        if (item) {
//            resultStr = [item description];
//        }
    }
    _playlistResultTextField.text = resultStr;

//    [self updateThumbnailImage];

    //
    // Enable buttons
    //
//    _fetchPlaylistButton.enabled = (!isFetchingPlaylist);
//    _playlistPopup.enabled = (isSignedIn && !isFetchingPlaylist);
//    _playlistCancelButton.enabled = isFetchingPlaylist;

    BOOL hasUploadTitle = true;//(_uploadTitleField.stringValue.length > 0);
    BOOL hasUploadFile = true;//(_uploadPathField.stringValue.length > 0);
    BOOL isUploading = (_uploadFileTicket != nil);
    BOOL isPaused = (isUploading && [_uploadFileTicket isUploadPaused]);
    BOOL canUpload = true;//(isSignedIn && hasUploadFile && hasUploadTitle && !isUploading);
    BOOL canRestartUpload = (_uploadLocationURL != nil);
    _uploadButton.enabled = canUpload;
    _pauseUploadButton.enabled = isUploading;
    _pauseUploadButton.titleLabel.text = (isPaused ? @"Resume" : @"Pause");
    _stopUploadButton.enabled = isUploading;
    _restartUploadButton.enabled = canRestartUpload;

    // Show or hide the text indicating that the client ID or client secret are
    // needed
    BOOL hasClientIDStrings = _clientIDField.text.length > 0
    && _clientSecretField.text.length > 0;
    _clientIDRequiredTextField.hidden = hasClientIDStrings;
}
//
//- (GTLRYouTube_PlaylistItem *)selectedPlaylistItem {
////    NSInteger row = [_playlistItemTable selectedRow];
////    if (row < 0) return nil;
//
////    GTLRYouTube_PlaylistItem *item = _playlistItemList[row];
//    return nil;//item
//}
//
//- (void)updateThumbnailImage {
//    // We will fetch the thumbnail image if its URL is different from the one
//    // currently displayed.
//    static NSString *gDisplayedURLStr = nil;
//
//    GTLRYouTube_PlaylistItem *playlistItem = [self selectedPlaylistItem];
//    GTLRYouTube_ThumbnailDetails *thumbnails = playlistItem.snippet.thumbnails;
//    GTLRYouTube_Thumbnail *thumbnail = thumbnails.defaultProperty;
//    NSString *thumbnailURLStr = thumbnail.url;
//
////    if (!GTLR_AreEqualOrBothNil(gDisplayedURLStr, thumbnailURLStr)) {
//        _thumbnailView.image = nil;
//
//        gDisplayedURLStr = [thumbnailURLStr copy];
//
//        if (thumbnailURLStr) {
//            GTMSessionFetcher *fetcher =
//            [self.youTubeService.fetcherService fetcherWithURLString:thumbnailURLStr];
//            fetcher.authorizer = self.youTubeService.authorizer;
//
//            NSString *title = playlistItem.snippet.title;
//            [fetcher setCommentWithFormat:@"Thumbnail for \"%@\"", title];
//            [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
//                if (data) {
//                    UIImage *image = [[UIImage alloc] initWithData:data];
//                    if (image) {
//                        self->_thumbnailView.image = image;
//                    } else {
//                        NSLog(@"Failed to make image from %tu bytes for \"%@\"",
//                              data.length, title);
//                    }
//                } else {
//                    NSLog(@"Failed to fetch thumbnail for \"%@\", %@",  title, error);
//                }
//            }];
//        }
////    }
//}
//
@end
