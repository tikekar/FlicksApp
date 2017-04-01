# Project 1 - FlicksApp

FlicksApp is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 10 hours spent in total

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/tikekar/FlicksApp/blob/master/FlicksApp_walkthrough.gif' title='Video Walkthrough' width='200px' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [x] Add a search bar.
- [x] All images fade in on the details page.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar and TabBar colors through AppDelegate.

The following **additional** features are implemented:
- Infinite Scrolling: Pass page number in the url query and fetch for infinite scroll.
- Used Container Views for the Now Playing and Top Rated tabs. This allowed me to create the Tab Bar in storyboard and still share the same FAMoviesViewController passing parameters regarding which list to load.
- In Movie Detials view, added the movie information view's panning and animation. (Panning gesture and animatewithDuration)
- Added SVProgressHUD using cocoapods for showing the simple progress bar
- Changed the TabBar background color and tint color

## Notes

Describe any challenges encountered while building the app.
- Creating panning (drag-drop) effect on movie details page was challenging. 

## License

    Copyright [2017] [Gauri Tikekar]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
