//
//  TTMusicSelectorViewController.m
//  TickTime
//
//  Created by AJ Green on 6/28/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTMusicSelectorViewController.h"
#import <MediaPlayer/MPMediaQuery.h>
#import <MediaPlayer/MPMediaPlaylist.h>

@interface TTMusicSelectorViewController ()

@property (nonatomic, strong) NSArray *iTunesSongs;

@end

@implementation TTMusicSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchAndPopulateiTunesSongs];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchAndPopulateiTunesSongs
{
    //----- LIST ALL SONGS -----
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    NSLog(@"Logging items from a generic query...");
    self.iTunesSongs = [everything items];
    for (MPMediaItem *song in self.iTunesSongs)
    {
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        NSLog (@"%@", songTitle);
        NSLog (@"\t%@", [song valueForProperty: MPMediaItemPropertyPersistentID]);
    }
}


#pragma mark - Tableview Datasource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.iTunesSongs.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"song"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"song"];
    }
    
    [[cell textLabel] setText:@"Song Title"];
    [[cell detailTextLabel] setText:@"Artist Name"];
    
    return cell;
}

#pragma mark - Tableview Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Save Song title or something and dismiss
}

@end
