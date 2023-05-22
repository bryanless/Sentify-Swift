# Sentify
Analyze sentiment of YouTube comments

An iOS app for YouTube content creators that help them find out the emotion of the comments by using sentiment analysis from a YouTube video link

## Features
### Analysis
- Search for a YouTube video using a link and analyze the comments' sentiment

## Getting Started
### Prerequisites
#### OS & Software
> Requirements might be lower, the app is developed using the system listed below
* macOS Ventura 13.3.1 (a)
* Xcode 14.3
* iOS 15.0

#### App
* YouTube API key from [Google Cloud Console](https://developers.google.com/youtube/v3/getting-started#before-you-start)
* Sentiment analysis model API key from [MonkeyLearn](https://monkeylearn.com)

### Installation
1. Download the repository
2. Open the project by using Xcode
3. Build the project and a `Keys.plist` file should be created automatically at `Sentify/Supporting Files/`
   > If it isn't created automatically, copy `Keys-Example.plist` at `Sentify/Supporting Files/` and paste it as `Keys.plist` at `Sentify/Supporting Files/`
4. Replace the value of key `YOUTUBE_API_KEY` with your YouTube API key at Keys.plist
5. Replace the value of key `MONKEYLEARN_API_KEY` with your sentiment analysis model API key at Keys.plist

## License
This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/bryanless/Sentify-Swift/blob/main/LICENSE) file for details

## Acknowledgments
* [YouTube API](https://developers.google.com/youtube/v3/getting-started#before-you-start) by [Google Cloud Console](https://console.cloud.google.com/)
* [Sentiment analysis API](https://monkeylearn.com) by [MonkeyLearn](https://monkeylearn.com)
