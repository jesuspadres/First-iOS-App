//
//  ViewController.swift
//  Jesus Padres
//
//  Created by Jessy Padres on 1/9/21.
//
// This application contains a three page scrollview that demonstrates knowledge and
// execution of an app on swift. The first page contains a brief description of me and
// a tap animation; the second page contains a sorting algorithm visualizer; and the
// third page contains a tic-tac-toe game.
//

import QuartzCore
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var juniCortez = UIImageView(image: #imageLiteral(resourceName: "94F2EBAF-6C4A-499D-9C0A-9BF43962EB3F_4_5005_c.jpeg"))
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    var startLabelsVisible = true
    var bars: [UIView] = []
    let sortButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    let barsButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    var picker = UIPickerView(frame: CGRect(x: 50, y: 100, width: 300, height: 30))
    var page1: UIView!
    var page2: UIView!
    var outerLoop = 0
    var innerLoop = 0
    var smallest = 0
    var boxes: [UIButton] = [];
    let ticTacButton = UIButton(frame: CGRect(x: 100, y: 100, width: 300, height: 50))
    let winnerLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 50))
    let sorters = ["Bubble Sort", "Insertion Sort", "Selection Sort"]
    var currSort: String = "Bubble Sort"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.dataSource = self
        picker.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        if (scrollView.subviews.count == 2) {
            configureScrollView()
        }
    }
    
    
    // Creates a three page scrollview
    //
    private func configureScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.size.width*3, height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        
        for x in 0..<3 {
            let page = UIView(frame: CGRect(x: CGFloat(x)*view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            
            if (x == 0) {
                firstPage(page: page)
            } else if(x == 1) {
                secondPage(page: page)
            } else if(x == 2) {
                thirdPage(page: page)
            }
            blurJuni()
            scrollView.addSubview(page)
        }
    }
    
/// First Page
    
    // Sets up the first page of the scrollview, with a description of myself, as well
    // as setting up the background and foreground subviews for the animation.
    //
    fileprivate func firstPage(page: UIView) {
        page1 = page
        page.addSubview(juniCortez)
        juniCortez.contentMode = .scaleAspectFill
        juniCortez.alpha = 0.7
        juniCortez.frame.size.width = page.frame.width
        juniCortez.frame.size.height = page.frame.height
        juniCortez.clipsToBounds = true
        
        titleLabel.numberOfLines = 0
        titleLabel.text = "Jesus Padres"
        titleLabel.font = UIFont(name: "Futura", size: 34)
        bodyLabel.numberOfLines = 0
        bodyLabel.text = "Senior Computer Science Undergraduate at the University of Arizona"
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        stackView.spacing = 8
        stackView.axis = .vertical
        page.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: page.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: page.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: page.widthAnchor, constant: -100).isActive = true
        
        page.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation)))
        
    }
    
    // Blurs background image when description subview is over it, unblurs it otherwise
    //
    fileprivate func blurJuni() {
        if(!startLabelsVisible) {
            for view in juniCortez.subviews {
              if let view = view as? UIVisualEffectView {
                view.alpha = 0
                view.removeFromSuperview()
              }
            }
        } else {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            juniCortez.addSubview(blurEffectView)
        }
        
    }
    
    // Handles animation to elegantly remove my description subview off of the screen
    //
    @objc fileprivate func handleTapAnimation() {
        if(startLabelsVisible != true) {
            returnTapAnimation()
            return
        }
        startLabelsVisible = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.titleLabel.alpha = 0
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -200)
                
            })
        }
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.bodyLabel.alpha = 0
                self.bodyLabel.transform = self.bodyLabel.transform.translatedBy(x: 0, y: -200)
                self.blurJuni()
            })
        }
    }
    
    // Handles animation to return my description subview on screen
    //
    @objc fileprivate func returnTapAnimation() {
        startLabelsVisible = true
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.blurJuni()
        })
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.bodyLabel.alpha = 1
            self.bodyLabel.transform = self.bodyLabel.transform.translatedBy(x: 0, y: 200)
            
            
        }) { (_) in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.bodyLabel.transform = CGAffineTransform(translationX: 30, y: 0)
            
            })
        }
        UIView.animate(withDuration: 0.4, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.titleLabel.alpha = 1
            self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: 200)
            
            
        }) { (_) in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.titleLabel.transform = CGAffineTransform(translationX: 30, y: 0)
                
            })
        }
    }
    
    
/// Second Page
    
    // Sets up the second page of the scrollview: it is a sorting visualizer of 24 bars
    // of random lengths, with buttons to sort and to reset the bars, as well as a picker
    // that picks the sorting algorithm.
    //
    fileprivate func secondPage(page: UIView) {
        page2 = page
        page.backgroundColor = .orange
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        page.addSubview(blurEffectView)
        generateBars()
        
        sortButton.frame = CGRect(x: 50, y: page.frame.height-200, width: 100, height: 50)
        sortButton.backgroundColor = .black
        sortButton.alpha = 0.6
        sortButton.setTitle("Sort", for: .normal)
        sortButton.addTarget(self, action: #selector(sortAction), for: .touchUpInside)
        page.addSubview(sortButton)
        
        barsButton.frame = CGRect(x: 220, y: page.frame.height-200, width: 100, height: 50)
        barsButton.backgroundColor = .black
        barsButton.alpha = 0.6
        barsButton.setTitle("Reset Bars", for: .normal)
        barsButton.addTarget(self, action: #selector(generateBars), for: .touchUpInside)
        page.addSubview(barsButton)
        
        picker.frame = CGRect(x: 50, y: page.frame.height-140, width: 300, height: 90)
        page.addSubview(picker)
    }
    
    // Executes the sorting visualizer depending on which sorting algorithm is selected
    // on the picker
    //
    @objc fileprivate func sortAction() {
        if(currSort == "Bubble Sort") {
            bubbleSort()
        } else if(currSort == "Selection Sort") {
            selecSort()
        } else {
            self.innerLoop = self.outerLoop+1
            insertSort()
        }
    }
    
    // Executes bubble sort sorting animation on the bars. Due to complexity of swift's chain
    // animations, this had do be done with a combination of chain animations and recursion.
    //
    fileprivate func bubbleSort() {
        barsButton.alpha = 0
        sortButton.alpha = 0
        picker.alpha = 0
        guard outerLoop < 24 else {
            self.bars[0].backgroundColor = .black
            barsButton.alpha = 0.6
            sortButton.alpha = 0.6
            picker.alpha = 1
            return
        }
        self.bars[self.innerLoop].backgroundColor = .yellow
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.025, delay: 0.025, options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                self.swapBar(a: self.innerLoop, b: self.innerLoop+1)
                if(self.innerLoop > 0) {
                    self.bars[self.innerLoop-1].backgroundColor = .white
                }
            },
            completion: { _ in
                self.innerLoop += 1
                if(self.innerLoop >= 24-self.outerLoop) {
                    self.bars[24-self.outerLoop].backgroundColor = .black
                    self.bars[24-self.outerLoop-1].backgroundColor = .white
                    self.outerLoop += 1
                    self.innerLoop = 0
                }
                self.bubbleSort()
        })
    }
    
    // Executes insertion sort sorting animation on the bars. Due to complexity of swift's chain
    // animations, this had do be done with a combination of chain animations and recursion.
    //
    fileprivate func insertSort() {
        barsButton.alpha = 0
        sortButton.alpha = 0
        picker.alpha = 0
        guard outerLoop < 24 else {
            self.bars[24].backgroundColor = .black
            barsButton.alpha = 0.6
            sortButton.alpha = 0.6
            picker.alpha = 1
            return
        }
        self.bars[self.innerLoop].backgroundColor = .yellow
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0.065, options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                if(self.bars[self.innerLoop].frame.width < self.bars[self.outerLoop].frame.width) {
                    self.swapInsert(curr: self.innerLoop-1, min: self.innerLoop)
                    self.outerLoop += 1
                    self.innerLoop = self.outerLoop
                    
                } else {
                    self.bars[self.innerLoop].backgroundColor = .white
                    self.innerLoop += 1
                }
            },
            completion: { _ in
                if(self.innerLoop <= 24) {
                    self.bars[self.innerLoop].backgroundColor = .white
                } else {
                    self.bars[self.outerLoop].backgroundColor = .black
                    self.outerLoop += 1
                    self.innerLoop = self.outerLoop+1
                }
                
                self.insertSort()
        })
    }
    
    // Executes selection sort sorting animation on the bars. Due to complexity of swift's chain
    // animations, this had do be done with a combination of chain animations and recursion.
    //
    fileprivate func selecSort() {
        barsButton.alpha = 0
        sortButton.alpha = 0
        picker.alpha = 0
        guard outerLoop < 24 else {
            self.bars[0].backgroundColor = .black
            barsButton.alpha = 0.6
            sortButton.alpha = 0.6
            picker.alpha = 1
            return
        }
        self.bars[self.innerLoop].backgroundColor = .yellow
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.025, delay: 0.025, options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                
                if(self.bars[self.smallest].frame.width < self.bars[self.innerLoop].frame.width) {
                    self.bars[self.innerLoop].backgroundColor = .white
                }
            },
            completion: { _ in
                if(self.bars[self.smallest].frame.width > self.bars[self.innerLoop].frame.width) {
                    self.bars[self.smallest].backgroundColor = .white
                    self.smallest = self.innerLoop
                }
               
                if(self.innerLoop >= 24) {
                    if(self.bars[self.smallest].frame.width < self.bars[self.outerLoop].frame.width) {
                        self.swapBar(a: self.outerLoop, b: self.smallest)
                    }
                    
                    self.bars[self.outerLoop].backgroundColor = .black
                    self.innerLoop = self.outerLoop
                    self.outerLoop += 1
                    self.smallest = self.outerLoop
                }
                if(self.outerLoop == 24) {
                    self.bars[self.outerLoop].backgroundColor = .black
                }
                self.innerLoop += 1
                // Call this function again on completion, but for the next card.
                self.selecSort()
        })
    
    }
    
    // Generates 24 white bars of random lengths
    //
    @objc fileprivate func generateBars() {
        outerLoop = 0
        innerLoop = 0
        for bar in bars {
            bar.removeFromSuperview()
        }
        bars.removeAll()
        for x in 0..<25 {
            let bar = UIView(frame: CGRect(x: 10, y: 100+(x*20), width: Int.random(in: 30...Int(page2.frame.width)-30), height: 10))
            bar.backgroundColor = .white
            page2.addSubview(bar)
            bars.append(bar)
            
        }
    }
    
    // Instead of swapping two bars with each other's spot, the bar at curr continuously
    // swaps with the bar next to it until it finds its appropriate spot, making it
    // appear as if it was an insertion and the other bars were pushed over.
    //
    fileprivate func swapInsert(curr: Int, min: Int) {
        var tmp = curr
        var min = min
        
        while(bars[tmp].frame.width > bars[min].frame.width) {
            let tmpBar = self.bars[tmp]
            self.bars[tmp] = self.bars[min]
            self.bars[min] = tmpBar
            let tmpY = self.bars[tmp].frame.origin.y
            self.bars[tmp].frame.origin.y = self.bars[min].frame.origin.y
            self.bars[min].frame.origin.y = tmpY
            self.bars[tmp].backgroundColor = .black
            min = tmp
            tmp -= 1
            if(tmp < 0) {
                return
            }
        }
    }
    
    // Swaps location of bars a and b
    //
    fileprivate func swapBar(a: Int, b: Int) {
        if(bars[a].frame.width > bars[b].frame.width) {
            let tmpBar = self.bars[a]
            self.bars[a] = self.bars[b]
            self.bars[b] = tmpBar
            let tmpY = self.bars[a].frame.origin.y
            self.bars[a].frame.origin.y = self.bars[b].frame.origin.y
            self.bars[b].frame.origin.y = tmpY
        }
    }
    
    
    /// Third Page
    
    // Sets up the third page of the scrollview: it is a tic-tac-toe game
    // played against the AI
    //
    fileprivate func thirdPage(page: UIView) {
        page.backgroundColor = .systemTeal
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        page.addSubview(blurEffectView)
        
        let square = UIView(frame: CGRect(x: 15, y: 200, width: page.frame.width-30, height: page.frame.width-30))
        square.backgroundColor = .gray
        square.alpha = 0.7
        page.addSubview(square)
        
        buildSquare(page: page)
        for i in 0..<9 {
            self.boxes[i].isEnabled = false
        }
        
        ticTacButton.frame = CGRect(x: 50, y: page.frame.height-250, width: 300, height: 70)
        ticTacButton.backgroundColor = .black
        ticTacButton.alpha = 0.6
        ticTacButton.setTitle("Start TicTacToe", for: .normal)
        ticTacButton.addTarget(self, action: #selector(startTicTac), for: .touchUpInside)
        page.addSubview(ticTacButton)
        
        winnerLabel.frame = CGRect(x: 50, y: page.frame.height-150, width: 300, height: 60)
        winnerLabel.font = UIFont(name: "Futura", size: 68)
        page.addSubview(winnerLabel)
    }
    
    // Initializes the tic-tac-toe game
    //
    @objc fileprivate func startTicTac() {
        winnerLabel.text = ""
        for i in 0..<9 {
            self.boxes[i].isEnabled = true
            self.boxes[i].setBackgroundImage(nil, for: .normal)
            self.boxes[i].backgroundColor = .white
        }
        ticTacButton.alpha = 0
    }
    
    // Builds the tic-tac-toe board
    //
    fileprivate func buildSquare(page: UIView) {
        for i in 0..<3 {
            let a = 5 + (page.frame.width-50)/3
            let b = CGFloat(i)*a
            let xVal = CGFloat(20+b)
            let box = UIButton(frame: CGRect(x: xVal, y: 205, width: (page.frame.width-50)/3, height: (page.frame.width-50)/3))
            box.backgroundColor = .white
            page.addSubview(box)
            box.tag = i;
            boxes.append(box)
            box.addTarget(self, action: #selector(ticTac), for: .touchUpInside)
        }
        for i in 0..<3 {
            let a = 5 + (page.frame.width-50)/3
            let b = CGFloat(i)*a
            let xVal = CGFloat(20+b)
            let box = UIButton(frame: CGRect(x: xVal, y: 210+(page.frame.width-50)/3, width: (page.frame.width-50)/3, height: (page.frame.width-50)/3))
            box.backgroundColor = .white
            page.addSubview(box)
            box.tag = i+3;
            boxes.append(box)
            box.addTarget(self, action: #selector(ticTac), for: .touchUpInside)
        }
        for i in 0..<3 {
            let a = 5 + (page.frame.width-50)/3
            let b = CGFloat(i)*a
            let xVal = CGFloat(20+b)
            let box = UIButton(frame: CGRect(x: xVal, y: 215+(page.frame.width-50)/1.5, width: (page.frame.width-50)/3, height: (page.frame.width-50)/3))
            box.backgroundColor = .white
            page.addSubview(box)
            box.tag = i+6;
            boxes.append(box)
            box.addTarget(self, action: #selector(ticTac), for: .touchUpInside)
        }
    }
    
    // Processes the tic-tac-toe game by animations and taking turns between the user and AI
    //
    @objc fileprivate func ticTac(sender: UIButton) {
        var didntGo = true
        
        for i in 0..<9 {
            self.boxes[i].isEnabled = false
        }
            
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
            if(sender.currentBackgroundImage == nil) {
                sender.setBackgroundImage(UIImage(named: "Transparent_X.png")!, for: .normal)
                didntGo = false
            }
        }) { (completed) in

            if(self.isWinner(pick: UIImage(named: "Transparent_X.png")!)) {
                for i in 0..<9 {
                    self.boxes[i].isEnabled = false
                }
                self.ticTacButton.alpha = 0.6
                self.ticTacButton.setTitle("Restart TicTacToe", for: .normal)
                self.winnerLabel.text = "You Win!"
                return
            }
            
            var bool = !didntGo
        
            while(bool) {
                var draw = true
                for i in 0..<9 {
                    if(self.boxes[i].currentBackgroundImage == nil) {
                        draw = false
                    }
                }
                if(draw) {
                    self.ticTacButton.alpha = 0.6
                    self.ticTacButton.setTitle("Restart TicTacToe", for: .normal)
                    self.winnerLabel.text = "Draw!"
                    return
                }
                let x = Int.random(in: 0...8)
                let box = self.boxes[x]
                
                if(box.currentBackgroundImage == nil) {
                    sleep(1)
                    box.setBackgroundImage(UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")!, for: .normal)
                    bool = false
                }
            }
            if(self.isWinner(pick: UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")!)) {
                for i in 0..<9 {
                    self.boxes[i].isEnabled = false
                }
                self.ticTacButton.alpha = 0.6
                self.ticTacButton.setTitle("Restart TicTacToe", for: .normal)
                self.winnerLabel.text = "You Lost"
                return
            }
        }
        for i in 0..<9 {
            self.boxes[i].isEnabled = true
        }
    }
    
    // Analyzes the board after each turn to check if there is a winner
    //
    fileprivate func isWinner(pick: UIImage) -> Bool {
        if(self.boxes[0].currentBackgroundImage == pick && self.boxes[1].currentBackgroundImage == pick && self.boxes[2].currentBackgroundImage == pick) {
            if(pick == UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")) {
                self.boxes[0].backgroundColor = .red
                self.boxes[1].backgroundColor = .red
                self.boxes[2].backgroundColor = .red
            } else {
                self.boxes[0].backgroundColor = .green
                self.boxes[1].backgroundColor = .green
                self.boxes[2].backgroundColor = .green
            }
            return true;
        }
        if(self.boxes[3].currentBackgroundImage == pick && self.boxes[4].currentBackgroundImage == pick && self.boxes[5].currentBackgroundImage == pick) {
            if(pick == UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")) {
                self.boxes[3].backgroundColor = .red
                self.boxes[4].backgroundColor = .red
                self.boxes[5].backgroundColor = .red
            } else {
                self.boxes[3].backgroundColor = .green
                self.boxes[4].backgroundColor = .green
                self.boxes[5].backgroundColor = .green
            }
            return true;
        }
        if(self.boxes[6].currentBackgroundImage == pick && self.boxes[7].currentBackgroundImage == pick && self.boxes[8].currentBackgroundImage == pick) {
            if(pick == UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")) {
                self.boxes[6].backgroundColor = .red
                self.boxes[7].backgroundColor = .red
                self.boxes[8].backgroundColor = .red
            } else {
                self.boxes[6].backgroundColor = .green
                self.boxes[7].backgroundColor = .green
                self.boxes[8].backgroundColor = .green
            }
            return true;
        }
        if(self.boxes[0].currentBackgroundImage == pick && self.boxes[3].currentBackgroundImage == pick && self.boxes[6].currentBackgroundImage == pick) {
            if(pick == UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")) {
                self.boxes[0].backgroundColor = .red
                self.boxes[3].backgroundColor = .red
                self.boxes[6].backgroundColor = .red
            } else {
                self.boxes[0].backgroundColor = .green
                self.boxes[3].backgroundColor = .green
                self.boxes[6].backgroundColor = .green
            }
            return true;
        }
        if(self.boxes[1].currentBackgroundImage == pick && self.boxes[4].currentBackgroundImage == pick && self.boxes[7].currentBackgroundImage == pick) {
            if(pick == UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")) {
                self.boxes[1].backgroundColor = .red
                self.boxes[4].backgroundColor = .red
                self.boxes[7].backgroundColor = .red
            } else {
                self.boxes[1].backgroundColor = .green
                self.boxes[4].backgroundColor = .green
                self.boxes[7].backgroundColor = .green
            }
            return true;
        }
        if(self.boxes[2].currentBackgroundImage == pick && self.boxes[5].currentBackgroundImage == pick && self.boxes[8].currentBackgroundImage == pick) {
            if(pick == UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")) {
                self.boxes[2].backgroundColor = .red
                self.boxes[5].backgroundColor = .red
                self.boxes[8].backgroundColor = .red
            } else {
                self.boxes[2].backgroundColor = .green
                self.boxes[5].backgroundColor = .green
                self.boxes[8].backgroundColor = .green
            }
            return true;
        }
        if(self.boxes[0].currentBackgroundImage == pick && self.boxes[4].currentBackgroundImage == pick && self.boxes[8].currentBackgroundImage == pick) {
            if(pick == UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")) {
                self.boxes[0].backgroundColor = .red
                self.boxes[4].backgroundColor = .red
                self.boxes[8].backgroundColor = .red
            } else {
                self.boxes[0].backgroundColor = .green
                self.boxes[4].backgroundColor = .green
                self.boxes[8].backgroundColor = .green
            }
            return true;
        }
        if(self.boxes[2].currentBackgroundImage == pick && self.boxes[4].currentBackgroundImage == pick && self.boxes[6].currentBackgroundImage == pick) {
            if(pick == UIImage(named: "o-png-89-images-in-collection-page-2-png-o-2000_2000.png")) {
                self.boxes[2].backgroundColor = .red
                self.boxes[4].backgroundColor = .red
                self.boxes[6].backgroundColor = .red
            } else {
                self.boxes[2].backgroundColor = .green
                self.boxes[4].backgroundColor = .green
                self.boxes[6].backgroundColor = .green
            }
            return true;
        }
        
        return false;
    }

}


/// Picker functions for the sorting algorithms
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sorters.count
    }

}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sorters[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currSort = sorters[row]
    }
}
