//
//  PlaybackView.swift
//  PitchPerfect
//
//  Created by Renan Maganha on 14/04/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct PlaybackView: View {
    @ObservedObject var recorderController  = AVRecorderController()
    @State var showCustomController = false
    @State var showAnimation        = false
    @State var pitchValue: Float    = 0
    @State var speedValue: Float    = 1
    @State var activeEcho   = false
    @State var activeReverb = false
    @State var tapSnail     = false
    @State var tapRabbit    = false
    @State var tapChipmunk  = false
    @State var tapVader     = false
    @State var tapEcho      = false
    @State var tapReverb    = false
    @State var tapStop      = false
    @State var tapCustom    = false
    @State var tapHear      = false
    @State var tapCave      = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                //MARK: - Playback Buttons
                HStack {
                    //MARK: - Show Custom Controller
                    Button(action: {
                        if self.showCustomController != true {
                            self.tapCustom.toggle()
                            self.recorderController.stopAudio()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.tapCustom.toggle()
                                self.showCustomController.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                                self.showAnimation.toggle()
                            }
                        }
                    }) {
                        CircleButton(image: "custom", firstColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), secondColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), thirdColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    .scaleEffect(tapCustom ? 1.2 : 1)
             
                    Spacer()
                    //MARK: - Slow voice
                    Button(action: {
                        self.tapSnail.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tapSnail.toggle()
                            self.recorderController.playSound(rate: 0.5)
                        }
                    }) {
                        CircleButton(image: "snail", firstColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), secondColor: #colorLiteral(red: 0.8477305143, green: 0.9822453288, blue: 0.8341080194, alpha: 1), thirdColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                    .scaleEffect(tapSnail ? 1.2 : 1)
 
                    Spacer()
                    //MARK: - Fast voice
                    Button(action: {
                        self.tapRabbit.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tapRabbit.toggle()
                            self.recorderController.playSound(rate: 1.5)
                        }
                    }) {
                        CircleButton(image: "rabbit", firstColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), secondColor: #colorLiteral(red: 1, green: 0.996848389, blue: 0.7639651893, alpha: 1), thirdColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    .scaleEffect(tapRabbit ? 1.2 : 1)

                }
                
                HStack{
                    //MARK: - Normal voice
                    Button(action: {
                        self.tapHear.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tapHear.toggle()
                            self.recorderController.playSound()
                        }
                    }) {
                        CircleButton(image: "hear", firstColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), secondColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), thirdColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                    .scaleEffect(tapHear ? 1.2 : 1)
             
                    Spacer()
                    //MARK: - High Pitch voice
                    Button(action: {
                        self.tapChipmunk.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tapChipmunk.toggle()
                            self.recorderController.playSound(pitch: 1000)
                        }
                    }) {
                        CircleButton(image: "chipmunk", firstColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), secondColor: #colorLiteral(red: 0.6870948775, green: 0.9475448401, blue: 1, alpha: 1), thirdColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                    .scaleEffect(tapChipmunk ? 1.2 : 1)

                    Spacer()
                    //MARK: - Low Pitch voice
                    Button(action: {
                        self.tapVader.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tapVader.toggle()
                            self.recorderController.playSound(pitch: -1000)
                        }
                    }) {
                        CircleButton(image: "vader", firstColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), secondColor: #colorLiteral(red: 1, green: 0.8416228505, blue: 0.7497802052, alpha: 1), thirdColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                    .scaleEffect(tapVader ? 1.2 : 1)
 
                }
                
                HStack{
                    //MARK: - Cave voice
                    Button(action: {
                        self.tapCave.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tapCave.toggle()
                            self.recorderController.playSound(echo: true, reverb: true)
                        }
                    }) {
                        CircleButton(image: "cave", firstColor: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), secondColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), thirdColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                    .scaleEffect(tapCave ? 1.2 : 1)

                    Spacer()
                    //MARK: Echo voice
                    Button(action: {
                        self.tapEcho.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tapEcho.toggle()
                            self.recorderController.playSound(echo: true)
                        }
                    }) {
                        CircleButton(image: "echo", firstColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), secondColor: #colorLiteral(red: 0.7058823529, green: 0.6588235294, blue: 0.968627451, alpha: 1), thirdColor: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                    .scaleEffect(tapEcho ? 1.2 : 1)
                    
                    Spacer()
                    //MARK: - Reverb voice
                    Button(action: {
                        self.tapReverb.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tapReverb.toggle()
                            self.recorderController.playSound(reverb: true)
                        }
                    }) {
                        CircleButton(image: "reverb", firstColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), secondColor: #colorLiteral(red: 0.9898126515, green: 0.7357468339, blue: 0.810477215, alpha: 1), thirdColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                    .scaleEffect(tapReverb ? 1.2 : 1)

                }

                //MARK: - Stop Button
                Button(action: {
                    self.tapStop.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tapStop.toggle()
                        self.recorderController.stopAudio()
                    }
                }) {
                    CircleButton(image: "stop", firstColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), secondColor: #colorLiteral(red: 0.7058823529, green: 0.6588235294, blue: 0.968627451, alpha: 1), thirdColor: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
                }
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .scaleEffect(tapStop ? 1.2 : 1)
                
            }//End of VStack
            .padding(.horizontal, 60)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.8396305432, green: 0.837597333, blue: 1, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
                
            VStack{
                if showCustomController {
                    CustomController(showCustomController: $showCustomController, showAnimation: $showAnimation,speedValue: $speedValue, pitchValue: $pitchValue, activeEcho: $activeEcho, activeReverb: $activeReverb)
                }
            }
        }//End of ZStack
    }
}

struct PlaybackView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackView()
    }
}

//MARK: - Custom Controller
struct CustomController: View {
    @ObservedObject var recorderController = AVRecorderController()
    @Binding var showCustomController: Bool
    @Binding var showAnimation: Bool
    @Binding var speedValue: Float
    @Binding var pitchValue: Float
    @Binding var activeEcho: Bool
    @Binding var activeReverb: Bool
    
    var body: some View {
        VStack{
            VStack{
                
                HStack {
                    Spacer()
                    
                    Button (action: {
                        self.showAnimation.toggle()
                        self.recorderController.stopAudio()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.showCustomController.toggle()
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .frame(width: 30, height: 30)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    })
                    
                }
                
                Text("Speed")
                
                Slider(value: $speedValue, in: 0.5...1.5, step: 0.1)
                    .accentColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                
                Text("Pitch")
                
                Slider(value: $pitchValue, in: -1000...1000, step: 100)
                    .accentColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                
                HStack {
                    VStack {
                        Toggle(isOn: $activeEcho) {
                            Text("Echo")
                        }
                        Toggle(isOn: $activeReverb) {
                            Text("Reverb")
                        }
                    }
                }
                
                Button (action: {
                    self.recorderController.playSound(rate: self.speedValue, pitch: self.pitchValue, echo: self.activeEcho, reverb: self.activeReverb)
                }, label: {
                    Image(systemName: "play.fill")
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                })
            }
            .padding(.horizontal, 20)
        }
        .frame(width: 300, height: 300)
        .background(Color.black.opacity(0.8))
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .animation(Animation.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0).delay(0.4))
        .offset(y: showAnimation ? 0 : 500)
        .opacity(showAnimation ? 1 : 0.5)
    }
}
