//
//  UserRequest.swift
//  SoundcloudSDK
//
//  Created by Kevin DELANNOY on 25/04/15.
//  Copyright (c) 2015 Kevin Delannoy. All rights reserved.
//

import Foundation

public extension User {
    internal static let BaseURL = NSURL(string: "https://api.soundcloud.com/users")!

    /**
     Loads an user profile

     - parameter identifier: The identifier of the user to load
     - parameter completion: The closure that will be called when user profile is loaded or upon error
     */
    public static func user(identifier: Int, completion: SimpleAPIResponse<User> -> Void) {
        guard let clientIdentifier = Soundcloud.clientIdentifier else {
            completion(SimpleAPIResponse(.CredentialsNotSet))
            return
        }

        let URL = BaseURL.URLByAppendingPathComponent("\(identifier).json")
        let parameters = ["client_id": clientIdentifier]

        let request = Request(URL: URL, method: .GET, parameters: parameters, parse: {
            if let user = User(JSON: $0) {
                return .Success(user)
            }
            return .Failure(.Parsing)
        }) { result in
            completion(SimpleAPIResponse(result))
        }
        request.start()
    }

    /**
     Loads tracks the user uploaded to Soundcloud

     - parameter completion: The closure that will be called when tracks are loaded or upon error
     */
    public func tracks(completion: PaginatedAPIResponse<Track> -> Void) {
        User.tracks(identifier, completion: completion)
    }

    /**
     Loads tracks the user uploaded to Soundcloud

     - parameter userIdentifier: The identifier of the user to load
     - parameter completion:     The closure that will be called when tracks are loaded or upon error
     */
    public static func tracks(userIdentifier: Int, completion: PaginatedAPIResponse<Track> -> Void) {
        guard let clientIdentifier = Soundcloud.clientIdentifier else {
            completion(PaginatedAPIResponse(.CredentialsNotSet))
            return
        }

        let URL = BaseURL.URLByAppendingPathComponent("\(userIdentifier)/tracks.json")
        let parameters = ["client_id": clientIdentifier, "linked_partitioning": "true"]

        let parse = { (JSON: JSONObject) -> Result<[Track], SoundcloudError> in
            guard let tracks = JSON.flatMap({ return Track(JSON: $0) }) else {
                return .Failure(.Parsing)
            }
            return .Success(tracks)
        }

        let request = Request(URL: URL, method: .GET, parameters: parameters, parse: { JSON -> Result<PaginatedAPIResponse<Track>, SoundcloudError> in
            return .Success(PaginatedAPIResponse(JSON, parse: parse))
        }) { result in
            completion(result.result!)
        }
        request.start()
    }

    /**
     Load all comments from the user

     - parameter completion: The closure that will be called when the comments are loaded or upon error
     */
    public func comments(completion: PaginatedAPIResponse<Comment> -> Void) {
        User.comments(identifier, completion: completion)
    }

    /**
     Load all comments from the user

     - parameter userIdentifier: The user identifier
     - parameter completion:     The closure that will be called when the comments are loaded or upon error
     */
    public static func comments(userIdentifier: Int, completion: PaginatedAPIResponse<Comment> -> Void) {
        guard let clientIdentifier = Soundcloud.clientIdentifier else {
            completion(PaginatedAPIResponse(.CredentialsNotSet))
            return
        }

        let URL = BaseURL.URLByAppendingPathComponent("\(userIdentifier)/comments.json")
        let parameters = ["client_id": clientIdentifier, "linked_partitioning": "true"]

        let parse = { (JSON: JSONObject) -> Result<[Comment], SoundcloudError> in
            guard let comments = JSON.flatMap({ return Comment(JSON: $0) }) else {
                return .Failure(.Parsing)
            }
            return .Success(comments)
        }

        let request = Request(URL: URL, method: .GET, parameters: parameters, parse: { JSON -> Result<PaginatedAPIResponse<Comment>, SoundcloudError> in
            return .Success(PaginatedAPIResponse(JSON, parse: parse))
        }) { result in
            completion(result.result!)
        }
        request.start()
    }

    /**
     Loads favorited tracks of the user

     - parameter completion: The closure that will be called when tracks are loaded or upon error
     */
    public func favorites(completion: PaginatedAPIResponse<Track> -> Void) {
        User.favorites(identifier, completion: completion)
    }

    /**
     Loads favorited tracks of the user

     - parameter userIdentifier: The user identifier
     - parameter completion:     The closure that will be called when tracks are loaded or upon error
     */
    public static func favorites(userIdentifier: Int, completion: PaginatedAPIResponse<Track> -> Void) {
        guard let clientIdentifier = Soundcloud.clientIdentifier else {
            completion(PaginatedAPIResponse(.CredentialsNotSet))
            return
        }

        let URL = BaseURL.URLByAppendingPathComponent("\(userIdentifier)/favorites.json")
        let parameters = ["client_id": clientIdentifier, "linked_partitioning": "true"]

        let parse = { (JSON: JSONObject) -> Result<[Track], SoundcloudError> in
            guard let tracks = JSON.flatMap({ return Track(JSON: $0) }) else {
                return .Failure(.Parsing)
            }
            return .Success(tracks)
        }

        let request = Request(URL: URL, method: .GET, parameters: parameters, parse: { JSON -> Result<PaginatedAPIResponse<Track>, SoundcloudError> in
            return .Success(PaginatedAPIResponse(JSON, parse: parse))
        }) { result in
            completion(result.result!)
        }
        request.start()
    }

    /**
     Loads followers of the user

     - parameter completion: The closure that will be called when followers are loaded or upon error
     */
    public func followers(completion: PaginatedAPIResponse<User> -> Void) {
        User.followers(identifier, completion: completion)
    }

    /**
     Loads followers of the user

     - parameter userIdentifier: The user identifier
     - parameter completion: The closure that will be called when followers are loaded or upon error
     */
    public static func followers(userIdentifier: Int, completion: PaginatedAPIResponse<User> -> Void) {
        guard let clientIdentifier = Soundcloud.clientIdentifier else {
            completion(PaginatedAPIResponse(.CredentialsNotSet))
            return
        }

        let URL = User.BaseURL.URLByAppendingPathComponent("\(userIdentifier)/followers.json")
        let parameters = ["client_id": clientIdentifier, "linked_partitioning": "true"]

        let parse = { (JSON: JSONObject) -> Result<[User], SoundcloudError> in
            guard let users = JSON.flatMap({ return User(JSON: $0) }) else {
                return .Failure(.Parsing)
            }
            return .Success(users)
        }

        let request = Request(URL: URL, method: .GET, parameters: parameters, parse: { JSON -> Result<PaginatedAPIResponse<User>, SoundcloudError> in
            return .Success(PaginatedAPIResponse(JSON, parse: parse))
        }) { result in
            completion(result.result!)
        }
        request.start()
    }

    /**
     Loads followed users of the user

     - parameter completion: The closure that will be called when followed users are loaded or upon error
     */
    public func followings(completion: PaginatedAPIResponse<User> -> Void) {
        User.followings(identifier, completion: completion)
    }

    /**
     Loads followed users of the user

     - parameter userIdentifier: The user identifier
     - parameter completion: The closure that will be called when followed users are loaded or upon error
     */
    public static func followings(userIdentifier: Int, completion: PaginatedAPIResponse<User> -> Void) {
        guard let clientIdentifier = Soundcloud.clientIdentifier else {
            completion(PaginatedAPIResponse(.CredentialsNotSet))
            return
        }

        let URL = User.BaseURL.URLByAppendingPathComponent("\(userIdentifier)/followings.json")
        let parameters = ["client_id": clientIdentifier, "linked_partitioning": "true"]

        let parse = { (JSON: JSONObject) -> Result<[User], SoundcloudError> in
            guard let users = JSON.flatMap({ return User(JSON: $0) }) else {
                return .Failure(.Parsing)
            }
            return .Success(users)
        }

        let request = Request(URL: URL, method: .GET, parameters: parameters, parse: { JSON -> Result<PaginatedAPIResponse<User>, SoundcloudError> in
            return .Success(PaginatedAPIResponse(JSON, parse: parse))
        }) { result in
            completion(result.result!)
        }
        request.start()
    }

    /**
     Follow the given user.

     **This method requires a Session.**

     - parameter userIdentifier: The identifier of the user to follow
     - parameter completion:     The closure that will be called when the user has been followed or upon error
     */
    @available(tvOS, unavailable)
    public func follow(userIdentifier: Int, completion: SimpleAPIResponse<Bool> -> Void) {
        #if !os(tvOS)
        User.changeFollowStatus(true, userIdentifier: userIdentifier, completion: completion)
        #endif
    }

    /**
     Follow the given user.

     **This method requires a Session.**

     - parameter userIdentifier: The identifier of the user to follow
     - parameter completion:     The closure that will be called when the user has been followed or upon error
     */
    @available(tvOS, unavailable)
    public static func follow(userIdentifier: Int, completion: SimpleAPIResponse<Bool> -> Void) {
        #if !os(tvOS)
        User.changeFollowStatus(true, userIdentifier: userIdentifier, completion: completion)
        #endif
    }

    /**
     Unfollow the given user.

     **This method requires a Session.**

     - parameter userIdentifier: The identifier of the user to unfollow
     - parameter completion:     The closure that will be called when the user has been unfollowed or upon error
     */
    @available(tvOS, unavailable)
    public func unfollow(userIdentifier: Int, completion: SimpleAPIResponse<Bool> -> Void) {
        #if !os(tvOS)
        User.changeFollowStatus(false, userIdentifier: userIdentifier, completion: completion)
        #endif
    }

    /**
     Unfollow the given user.

     **This method requires a Session.**

     - parameter userIdentifier: The identifier of the user to unfollow
     - parameter completion:     The closure that will be called when the user has been unfollowed or upon error
     */
    @available(tvOS, unavailable)
    public static func unfollow(userIdentifier: Int, completion: SimpleAPIResponse<Bool> -> Void) {
        #if !os(tvOS)
        User.changeFollowStatus(false, userIdentifier: userIdentifier, completion: completion)
        #endif
    }

    @available(tvOS, unavailable)
    static func changeFollowStatus(follow: Bool, userIdentifier: Int, completion: SimpleAPIResponse<Bool> -> Void) {
        #if !os(tvOS)
        guard let clientIdentifier = Soundcloud.clientIdentifier else {
            completion(SimpleAPIResponse(.CredentialsNotSet))
            return
        }

        guard let oauthToken = Soundcloud.session?.accessToken else {
            completion(SimpleAPIResponse(.NeedsLogin))
            return
        }

        let parameters = ["client_id": clientIdentifier, "oauth_token": oauthToken]
        let URL = BaseURL.URLByDeletingLastPathComponent!.URLByAppendingPathComponent("me/followings/\(userIdentifier).json").URLByAppendingQueryString(parameters.queryString)

        let request = Request(URL: URL, method: follow ? .PUT : .DELETE, parameters: nil, parse: { _ in
            return .Success(true)
        }) { result in
            completion(SimpleAPIResponse(result))
        }
        request.start()
        #endif
    }

    /**
     Loads user's playlists

     - parameter completion: The closure that will be called when playlists has been loaded or upon error
     */
    public func playlists(completion: PaginatedAPIResponse<Playlist> -> Void) {
        User.playlists(identifier, completion: completion)
    }

    /**
     Loads user's playlists

     - parameter userIdentifier: The identifier of the user to unfollow
     - parameter completion: The closure that will be called when playlists has been loaded or upon error
     */
    public static func playlists(userIdentifier: Int, completion: PaginatedAPIResponse<Playlist> -> Void) {
        guard let clientIdentifier = Soundcloud.clientIdentifier else {
            completion(PaginatedAPIResponse(.CredentialsNotSet))
            return
        }

        let URL = BaseURL.URLByAppendingPathComponent("\(userIdentifier)/playlists.json")
        let parameters = ["client_id": clientIdentifier, "linked_partitioning": "true"]

        let parse = { (JSON: JSONObject) -> Result<[Playlist], SoundcloudError> in
            guard let playlists = JSON.flatMap({ return Playlist(JSON: $0) }) else {
                return .Failure(.Parsing)
            }
            return .Success(playlists)
        }

        let request = Request(URL: URL, method: .GET, parameters: parameters, parse: { JSON -> Result<PaginatedAPIResponse<Playlist>, SoundcloudError> in
            return .Success(PaginatedAPIResponse(JSON, parse: parse))
        }) { result in
            completion(result.result!)
        }
        request.start()
    }
}
