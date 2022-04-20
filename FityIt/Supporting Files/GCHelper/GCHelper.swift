
import GameKit

public protocol GCHelperDelegate: class {
    
    func matchStarted()
    
    func match(_ match: GKMatch, didReceiveData: Data, fromPlayer: String)
    
    func matchEnded()
}

public class GCHelper: NSObject, GKMatchmakerViewControllerDelegate, GKGameCenterControllerDelegate, GKMatchDelegate, GKLocalPlayerListener {
    
    public var achievements = [String: GKAchievement]()
    
    public var match: GKMatch!
    
    fileprivate weak var delegate: GCHelperDelegate?
    fileprivate var invite: GKInvite!
    fileprivate var invitedPlayer: GKPlayer!
    fileprivate var playersDict = [String: AnyObject]()
    fileprivate weak var presentingViewController: UIViewController!
    
    fileprivate var authenticated = false {
        didSet {
            print("Authentication changed: player\(authenticated ? " " : " not ")authenticated")
        }
    }
    
    fileprivate var matchStarted = false
    
    public class var sharedInstance: GCHelper {
        struct Static {
            static let instance = GCHelper()
        }
        return Static.instance
    }
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(GCHelper.authenticationChanged), name: Notification.Name.GKPlayerAuthenticationDidChangeNotificationName, object: nil)
    }
    
    // MARK: Private functions
    
    @objc fileprivate func authenticationChanged() {
        if GKLocalPlayer.local.isAuthenticated && !authenticated {
            authenticated = true
        } else {
            authenticated = false
        }
    }
    
    fileprivate func lookupPlayers() {
        let playerIDs = match.players.map { $0.playerID } 
        
        GKPlayer.loadPlayers(forIdentifiers: playerIDs) { (players, error) in
            guard error == nil else {
                print("Error retrieving player info: \(String(describing: error?.localizedDescription))")
                self.matchStarted = false
                self.delegate?.matchEnded()
                return
            }
            
            guard let players = players else {
                print("Error retrieving players; returned nil")
                return
            }
            
            for player in players {
                print("Found player: \(String(describing: player.alias))")
                self.playersDict[player.playerID] = player
            }
            
            self.matchStarted = true
            GKMatchmaker.shared().finishMatchmaking(for: self.match)
            self.delegate?.matchStarted()
        }
    }
    
    // MARK: User functions
    
    public func authenticateLocalUser() {
        print("Authenticating local user...")
        
        if GKLocalPlayer.local.isAuthenticated == false {
            GKLocalPlayer.local.authenticateHandler = { (view, error) in
                guard error == nil else {
                    print("Authentication error: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                self.authenticated = true
            }
        } else {
            print("Already authenticated")
        }
    }

    public func findMatchWithMinPlayers(_ minPlayers: Int, maxPlayers: Int, viewController: UIViewController, delegate theDelegate: GCHelperDelegate) {
        matchStarted = false
        match = nil
        presentingViewController = viewController
        delegate = theDelegate
        presentingViewController.dismiss(animated: false, completion: nil)
        
        let request = GKMatchRequest()
        request.minPlayers = minPlayers
        request.maxPlayers = maxPlayers
        
        let mmvc = GKMatchmakerViewController(matchRequest: request)!
        mmvc.matchmakerDelegate = self
        
        presentingViewController.present(mmvc, animated: true, completion: nil)
    }

    public func reportAchievementIdentifier(_ identifier: String, percent: Double, showsCompletionBanner banner: Bool = true) {
        let achievement = GKAchievement(identifier: identifier)
        
        if !achievementIsCompleted(identifier) {
            achievement.percentComplete = percent
            achievement.showsCompletionBanner = banner
            
            GKAchievement.report([achievement]) { (error) in
                guard error == nil else {
                    print("Error in reporting achievements: \(String(describing: error))")
                    return
                }
            }
        }
    }
    

    public func loadAllAchievements(_ completion: (() -> Void)? = nil) {
        GKAchievement.loadAchievements { (achievements, error) in
            guard error == nil, let achievements = achievements else {
                print("Error in loading achievements: \(String(describing: error))")
                return
            }
            
            for achievement in achievements {
                self.achievements[achievement.identifier] = achievement
            }
            
            completion?()
        }
    }
  
    public func achievementIsCompleted(_ identifier: String) -> Bool {
        if let achievement = achievements[identifier] {
            return achievement.percentComplete == 100
        }
        
        return false
    }
   
    public func resetAllAchievements() {
        GKAchievement.resetAchievements { (error) in
            guard error == nil else {
                print("Error resetting achievements: \(String(describing: error))")
                return
            }
        }
    }
  
    public func reportLeaderboardIdentifier(_ identifier: String, score: Int) {
        let scoreObject = GKScore(leaderboardIdentifier: identifier)
        scoreObject.value = Int64(score)
        GKScore.report([scoreObject]) { (error) in
            guard error == nil else {
                print("Error in reporting leaderboard scores: \(String(describing: error))")
                return
            }
        }
    }

    public func showGameCenter(_ viewController: UIViewController, viewState: GKGameCenterViewControllerState) {
        presentingViewController = viewController
        
        let gcvc = GKGameCenterViewController()
        gcvc.viewState = viewState
        gcvc.gameCenterDelegate = self
        presentingViewController.present(gcvc, animated: true, completion: nil)
    }
    
    // MARK: GKGameCenterControllerDelegate
    
    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: GKMatchmakerViewControllerDelegate
    
    public func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    public func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        presentingViewController.dismiss(animated: true, completion: nil)
        print("Error finding match: \(error.localizedDescription)")
    }
    
    public func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind theMatch: GKMatch) {
        presentingViewController.dismiss(animated: true, completion: nil)
        match = theMatch
        match.delegate = self
        if !matchStarted && match.expectedPlayerCount == 0 {
            print("Ready to start match!")
            self.lookupPlayers()
        }
    }
    
    // MARK: GKMatchDelegate
    
    public func match(_ theMatch: GKMatch, didReceive data: Data, fromPlayer playerID: String) {
        if match != theMatch {
            return
        }
        
        delegate?.match(theMatch, didReceiveData: data, fromPlayer: playerID)
    }
    
    public func match(_ theMatch: GKMatch, player playerID: String, didChange state: GKPlayerConnectionState) {
        if match != theMatch {
            return
        }
        
        switch state {
        case .connected where !matchStarted && theMatch.expectedPlayerCount == 0:
            lookupPlayers()
        case .disconnected:
            matchStarted = false
            delegate?.matchEnded()
            match = nil
        default:
            break
        }
    }
    
    public func match(_ theMatch: GKMatch, didFailWithError error: Error?) {
        if match != theMatch {
            return
        }
        
        print("Match failed with error: \(String(describing: error?.localizedDescription))")
        matchStarted = false
        delegate?.matchEnded()
    }
    
    // MARK: GKLocalPlayerListener
    
    public func player(_ player: GKPlayer, didAccept inviteToAccept: GKInvite) {
        let mmvc = GKMatchmakerViewController(invite: inviteToAccept)!
        mmvc.matchmakerDelegate = self
        presentingViewController.present(mmvc, animated: true, completion: nil)
    }
}
