//
//  ViewController.m
//  Tar Extractor
//
//  Created by appledeveloper on 19/03/19.
//  Copyright © 2019 Senthilkumar K. All rights reserved.
//

#import "ViewController.h"
#import "NSFileManager+Tar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getCacheDirectory];
    
    [self extractWithTarFolder:@"example" tarfileName:@"example"];// Provide Your Tar file here
    
}

#pragma mark - Get Cache Directory
-(NSString*) getCacheDirectory {
    
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"Cache Directory = %@",cacheDirectory);
    
    return cacheDirectory;
    
}



-(void)extractWithTarFolder:(NSString*)folderName tarfileName:(NSString*)fileName {
    
    // Source Path - Tar File
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *finalName = [NSString stringWithFormat:@"%@.tar",fileName];
    NSString *sourcePath = [cacheDirectory stringByAppendingPathComponent:finalName];
    
    
    
    NSString *destinationPath;
    NSError *error;
    
    // Destination Folder - Own Empty Folder
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    
    NSString *slashStr = [NSString stringWithFormat:@"/"];
    NSString *dirName = [NSString stringWithFormat:@"%@%@",slashStr,folderName];
    destinationPath = [documentsDirectory stringByAppendingPathComponent:dirName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:destinationPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    
    
    // Copy paste your sample tar file to Cache Directory
    
    // Tar Extractor
    
    // Provide the Source and Destination
    BOOL isExtracted = [[NSFileManager defaultManager] createFilesAndDirectoriesAtPath:destinationPath
                                                                           withTarPath:sourcePath
                                                                                 error:&error
                                                                              progress:nil];
    
    // Check Extracted or not
    if (isExtracted == true){
        NSLog(@"Extracted");
    }else {
        NSLog(@"Not Extracted");

    }
    

}




@end
