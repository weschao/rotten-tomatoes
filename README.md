## Rotten Tomatoes

This is a movies app displaying box office and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: 10h, plus 2h in lab

### Features

#### Required

- [x] User can view a list of movies. Poster images load asynchronously. 
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees error message when there is a network error: http://cl.ly/image/1l1L3M460c3C
- [x] User can pull to refresh the movie list.

#### Optional

- [x] All images fade in.
- [x] For the larger poster, load the low-res first and switch to high-res when complete.
- [ ] All images should be cached in memory and disk.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.
- [x] Add a tab bar for Box Office and DVD.
- [x] Add a search bar: pretty simple implementation of searching against the existing table view data.
- [ ] Implement segmented control to switch between list view and grid view.

### Walkthrough
![Video Walkthrough](http://i.imgur.com/tTrlVQ0.gif)

Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)