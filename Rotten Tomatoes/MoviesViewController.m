//
//  MoviesViewController.m
//  Rotten Tomatoes
//
//  Created by Wes Chao on 10/13/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesViewController ()<UITableViewDataSource, UITableViewDelegate, UITabBarDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray* topRentals;
@property UIRefreshControl *refreshControl;
@property UIActivityIndicatorView *loadingView;
@property NSString *rottenTomatoesUrlString;
@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // set the tab bar item images and the tint color for selected images to match the nav bar color
    self.topDVDItem.image = [[UIImage imageNamed:@"DVDIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.topDVDItem.selectedImage = [[UIImage imageNamed:@"DVDIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];;

    self.boxOfficeItem.image = [[UIImage imageNamed:@"MovieIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.boxOfficeItem.selectedImage = [[UIImage imageNamed:@"MovieIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];;
    
    self.mainTabBar.tintColor = [UIColor colorWithRed:58.0/255.0f green:147.0/255.0f blue:36.0/255.0f alpha:1.0f];

    // add a search button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                              target:self
                                              action:@selector(onSearchButton)];


    self.networkErrorView.hidden = YES;

    [self.networkErrorOKButton addTarget:self action:@selector(clearNetworkErrorView) forControlEvents:UIControlEventTouchUpInside];

    self.mainTabBar.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib: [UINib nibWithNibName:@"MovieCell" bundle: nil]
         forCellReuseIdentifier:@"MovieCell"];
    
    self.tableView.rowHeight = 160;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // Display loading spinner, but only on app start (refresh has its own spinner)
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingView.center=self.view.center;
    [self.view addSubview:self.loadingView];
    [self.loadingView startAnimating];
    self.loadingView.hidden = NO;
    
    // default view is top rentals
    [self.mainTabBar setSelectedItem:[self.mainTabBar.items objectAtIndex:1]];
    self.rottenTomatoesUrlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=nxu96vjy2huu9g3vd3kjfd2g";
    self.title = @"Top DVDs";
    
    [self reloadData];
  }

- (void) clearNetworkErrorView
{
    self.networkErrorView.hidden = YES;
}

- (void) reloadData
{
    // make a request for data
    NSURL *url = [NSURL URLWithString:self.rottenTomatoesUrlString];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:2*60]; // New line

    // DEBUG: Check the cache.
    NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    NSLog(cachedResponse ? @"Cached response found!" : @"No cached response found.");
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
            self.topRentals = responseDictionary[@"movies"];
            [self.moviesTableView reloadData];
        }
        else {
            self.networkErrorView.hidden = NO;
        }
        
        [self.refreshControl endRefreshing];
        [self.loadingView stopAnimating];
        self.loadingView.hidden = YES;
    }];
}

- (void) onRefresh
{
    [self reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onSearchButton
{
    self.movieSearchBar.alpha = 0.0;
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.5];
    self.movieSearchBar.alpha = 1.0;
    self.movieSearchBar.hidden = NO;
    [UIView commitAnimations];

    //TODO: slide the table view down

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(searchText);
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.movieSearchBar.hidden = YES;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag==0)
    {
        self.rottenTomatoesUrlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=nxu96vjy2huu9g3vd3kjfd2g";
        self.title = @"Box Office";
        [self reloadData];
    }
    else
    {
        self.rottenTomatoesUrlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=nxu96vjy2huu9g3vd3kjfd2g";
        self.title = @"Top DVDs";
        [self reloadData];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MovieDetailsViewController* mdvc = [[MovieDetailsViewController alloc] init];
    mdvc.movie = self.topRentals[indexPath.row];
    [self.navigationController pushViewController:mdvc animated:YES];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topRentals.count;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [[MovieCell alloc] init];
    cell = [self.moviesTableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.topRentals[indexPath.row];

    // get the low res image
    NSString *lowResPhotoUrl = [movie valueForKeyPath:@"posters.thumbnail"];
    UIImage *lowResImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:lowResPhotoUrl]]];

    NSString *highResPhotoUrl = [lowResPhotoUrl stringByReplacingOccurrencesOfString: @"tmb" withString:@"ori"];
    [cell.photoView setImageWithURL:[NSURL URLWithString:highResPhotoUrl] placeholderImage:lowResImage];
    
    cell.titleLabel.text = [movie valueForKeyPath:@"title"];
    cell.synopsisLabel.text = [movie valueForKeyPath:@"synopsis"];
    
    cell.photoView.alpha = 0.0;
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:2.0];
    cell.photoView.alpha = 1.0;
    [UIView commitAnimations];

    return cell;
}

@end
