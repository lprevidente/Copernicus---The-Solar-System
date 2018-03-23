import UIKit
import PlaygroundSupport

// Set InitialiView  as current PlaygroundPage 
let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main);
let initialPageLiveView = storyboard.instantiateViewController(withIdentifier: "InitialPageViewController")
PlaygroundPage.current.liveView = initialPageLiveView;
