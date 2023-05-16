import XCTest
import Alamofire
import Combine
@testable import YouTube

final class YouTubeTests: XCTestCase {
  let apiKey = YouTubeApi.apiKey

  var cancellables: Set<AnyCancellable> = []

  func testGetVideoRemoteDataSourceById() {
    let endpoint = YouTubeEndpoints.Gets.videos.url
    let remote = GetVideoRemoteDataSource(endpoint: endpoint, apiKey: apiKey)
    let request = VideoRemoteRequest(id: "KfPLZkgwAEQ", key: apiKey)

    var errorMessage: String?
    var response: [VideoResponse]?
    let expectation = self.expectation(description: "Videos")

    remote.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          errorMessage = error.localizedDescription
        case .finished:
          break
        }

        expectation.fulfill()
      }, receiveValue: { items in
        response = items
      })
      .store(in: &cancellables)

    // Awaiting fulfilment of our expecation before
    // performing our asserts:
    waitForExpectations(timeout: 5)

    // Asserting that our Combine pipeline yielded the
    // correct output:
    XCTAssertNil(errorMessage)
    XCTAssertNotNil(response)
  }

  func testGetCommentThreadRemoteDataSource() {
    let endpoint = YouTubeEndpoints.Gets.commentThreads.url
    let remote = GetCommentThreadRemoteDataSource(endpoint: endpoint, apiKey: apiKey)
    let request = CommentThreadRemoteRequest(videoId: "rVMDjvPWNa4", key: apiKey)

    var errorMessage: String?
    var response: [CommentThreadResponse]?
    let expectation = self.expectation(description: "Comment Threads")

    remote.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          errorMessage = error.localizedDescription
        case .finished:
          break
        }

        expectation.fulfill()
      }, receiveValue: { items in
        response = items
      })
      .store(in: &cancellables)

    // Awaiting fulfilment of our expecation before
    // performing our asserts:
    waitForExpectations(timeout: 5)

    // Asserting that our Combine pipeline yielded the
    // correct output:
    XCTAssertNil(errorMessage)
    XCTAssertNotNil(response)
  }
}

struct YouTubeApi {

  static let baseUrl = "https://www.googleapis.com/youtube/v3/"
  static let apiKey = "AIzaSyC0JYrEqF4MlojfiTXf-m92H3MgNQexMEw"

}

protocol Endpoint {

  var url: String { get }

}

enum YouTubeEndpoints {

  enum Gets: Endpoint {
    case search
    case playlistItems
    case videos
    case commentThreads

    public var url: String {
      switch self {
      case .search: return "\(YouTubeApi.baseUrl)search"
      case .playlistItems: return "\(YouTubeApi.baseUrl)playlistItems"
      case .videos: return "\(YouTubeApi.baseUrl)videos"
      case .commentThreads: return "\(YouTubeApi.baseUrl)commentThreads"
      }
    }
  }

}
