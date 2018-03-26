import UIKit
import PlaygroundSupport

let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main);
let liveSceneView = storyBoard.instantiateViewController(withIdentifier: "SceneViewController");
PlaygroundPage.current.liveView = liveSceneView
