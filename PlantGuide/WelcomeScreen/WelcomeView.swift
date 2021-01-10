//
//  WelcomeView.swift
//  PlantGuide
//
//  Created by (non work) on 27.10.20.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isTutorialVisible: Bool

    @State var stage: Int = 0
    
    var blue = Color("welcomeBlue")
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        
        if isTutorialVisible == false {
            EmptyView()
        } else {
            ZStack {
                Rectangle()
                    .opacity(0.6)
                
                VStack {
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(blue)
                            .edgesIgnoringSafeArea(.all)
                            .cornerRadius(15)
                        
                        VStack {
                            HStack {
                                
                                Button(action: {
                                    withAnimation(.easeIn(duration: 0.2)) {
                                        isTutorialVisible.toggle()
                                        self.feedback.impactOccurred()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            self.stage = 0
                                              }
                                       
                                    }
                                    
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding()
                                        .foregroundColor(Color(.black))
                                        .opacity(0.3)
                                })
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.easeIn(duration: 0.8)) {
                                        if self.stage <= 2 {
                                            self.stage = stage + 1
                                        } else {
                                            isTutorialVisible.toggle()
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                self.stage = 0
                                                  }
                                        }
                                        self.feedback.impactOccurred()
                                    }
                                }, label: {
                                    Text("Next")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.white))
                                        .padding(.trailing)
                                })
                                
                            }
                            
                            Spacer()
                        }
                        
                        VStack {
                            
                            if self.stage == 0 {
                                IllustrationView()
                                    .transition(.moveInOut)
                                    
                            } else {
                                TutorialView(stage: self.stage)
                                    
                            }

                            Spacer()
                        }
                        Spacer()
                    }.frame(height: 400)
                    .clipped()
                    .shadow(radius: 10)
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView(isTutorialVisible: Binding.constant(true))
            WelcomeView(isTutorialVisible: Binding.constant(true))
                .preferredColorScheme(.dark)
        }
            
    }
}


extension AnyTransition {
    static var moveInOut: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
        let removal = AnyTransition.move(edge: .leading)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
