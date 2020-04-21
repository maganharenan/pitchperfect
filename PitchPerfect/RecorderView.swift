//
//  ContentView.swift
//  PitchPerfect
//
//  Created by Renan Maganha on 09/04/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import AVFoundation

struct RecorderView: View {
    @ObservedObject var recorderController = AVRecorderController()
    @State var press        = false
    @State var tap          = false
    @State var tapStop      = false
    @State var isRecording  = false
    @State var isRecorded   = false
    
    var body: some View {
        
        DispatchQueue.main.async {
            self.isRecorded   = self.recorderController.isRecorded
        }
        
        return NavigationView{
            VStack {
                MessageView(press: $press)
                
                Image(systemName: press ? "mic.fill" : "mic")
                    .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                    .imageScale(.large)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .frame(width: 180, height: 180)
                    .background(
                        ZStack {
                            Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7058823529, green: 0.6588235294, blue: 0.968627451, alpha: 1))
                            
                            Circle()
                                .foregroundColor(Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) :#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ))
                                .blur(radius: 4)
                                .offset(x: -8, y: -8)
                            
                            Circle()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7058823529, green: 0.6588235294, blue: 0.968627451, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    
                            )
                                .padding(2)
                                .blur(radius: 2)
                        }
                )
                    .clipShape(Circle())
                    .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7058823529, green: 0.6588235294, blue: 0.968627451, alpha: 1)), radius: 20, x: 20, y: 20)
                    .shadow(color: Color(press ? #colorLiteral(red: 0.7058823529, green: 0.6588235294, blue: 0.968627451, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
                    .scaleEffect(tap ? 1.2 : 1)
                    .gesture(LongPressGesture(minimumDuration: 0.5, maximumDistance: 10)
                        .onChanged{ value in
                            if !self.isRecording {
                                self.tap = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    self.tap = false
                                }
                            }
                    }
                    .onEnded{ value in
                        if !self.isRecording {
                            self.startRecordingAudio()
                        }
                        }
                )
                
                NavigationLink(destination: PlaybackView(), isActive: $isRecorded) {
                      Image(systemName: "stop.fill")
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .imageScale(.large)
                        .frame(width: press ? 70 : 0, height: press ? 70 : 0)
                        .background(
                            ZStack {
                                Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
                                
                                Circle()
                                    .foregroundColor(Color(#colorLiteral(red: 0.7058823529, green: 0.6588235294, blue: 0.968627451, alpha: 1)))
                                    .blur(radius: 4)
                                    .offset(x: -8, y: -8)
                                
                                Circle()
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        
                                )
                                    .padding(2)
                                    .blur(radius: 2)
                            }
                      )
                        .clipShape(Circle())
                        .shadow(color: Color(#colorLiteral(red: 0.7058823529, green: 0.6588235294, blue: 0.968627451, alpha: 1)), radius: 10, x: 10, y: 10)
                        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 10, x: -10, y: -10)
                        .scaleEffect(tapStop ? 1.2 : 1)
                        .onTapGesture {
                            self.tapStop.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.stopRecordingAudio()
                            }
                      }
                      .padding(.top, 30)
                      .offset(y: press ? 0 : -150)
                      .opacity(press ? 1 : 0)
                      .animation(.easeInOut)
                }
            
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.8396305432, green: 0.837597333, blue: 1, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
        }
        .background(Color(#colorLiteral(red: 0.8396305432, green: 0.837597333, blue: 1, alpha: 1)))
    }
    
    //MARK: - Functions
    func startRecordingAudio() {
        self.press.toggle()
        self.isRecording = true
        self.recorderController.recordAudio()
    }
    
    func stopRecordingAudio() {
        self.tapStop = false
        self.press.toggle()
        self.isRecording = false
        self.recorderController.stopRecording()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView(recorderController: AVRecorderController())
    }
}

//MARK: - Stroke Text
struct MessageView: View {
    @Binding var press: Bool
    
    var body: some View {
        ZStack {
            Text(press ? "Recording in progress" : "Long press to record")
                .font(.title)
                .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
            
            
            Text(press ? "Recording in progress" : "Long press to record")
                .font(.title)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .blur(radius: 1)
                .offset(x: -2, y: -2)
            
            Text(press ? "Recording in progress" : "Long press to record")
                .font(.title)
                .foregroundColor(Color(#colorLiteral(red: 0.7058823529, green: 0.6588235294, blue: 0.968627451, alpha: 1)))
                .blur(radius: 3)
                .offset(x: 2, y: 2)
            
            Text(press ? "Recording in progress" : "Long press to record")
                .font(.title)
                .foregroundColor(Color(#colorLiteral(red: 0.897300134, green: 0.900461324, blue: 1, alpha: 1)))
        }
        .padding(.bottom, 30)
        .shadow(color: Color(#colorLiteral(red: 0.5682276165, green: 0.5304496738, blue: 0.7868975969, alpha: 1)), radius: 1, x: 1, y: 1)
        .animation(.easeIn)
    }
}
