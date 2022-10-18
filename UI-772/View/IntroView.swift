//
//  IntroView.swift
//  UI-772
//
//  Created by nyannyan0328 on 2022/10/18.
//

import SwiftUI

struct IntroView: View {
    @State var showHome : Bool = false
    @State var currentIndex : Int = 0
    @State var workThrought : Bool = false
    @Namespace var animation
    var body: some View {
        if showHome{
            
            sampleHome().transition(.move(edge: .leading))
        }
        else{
            
            ZStack{
                
                Color("BG").ignoresSafeArea()
                
                introScreen()
                
                
                workThroughtScrren()
                
                
                navBar()
                
                
            }
            .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: workThrought)
            
        }
    }
    @ViewBuilder
    func workThroughtScrren ()->some View{
        
        let isLast = currentIndex == intros.count
        
        GeometryReader{
            
            let size = $0.size
         
            ZStack{
                
                ForEach(intros.indices ,id:\.self){index in
                    
                    ScreenView(size: size, index: index)
                    
                }
                Welcome(size: size, index: intros.count)
                
            }
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .overlay(alignment: .bottom) {
                  
                  Indicators()
                      .opacity(isLast ? 0 : 1)
                      .offset(y:-180)
                      .animation(.easeInOut, value: isLast)
              }
              .overlay(alignment: .bottom) {
                  
                  ZStack{
                      
                      Image(systemName: "chevron.right")
                          .font(.title3)
                          .scaleEffect(!isLast ? 1 : 0.001)
                          .opacity(!isLast ? 1 : 0)
                      
                      
                      HStack{
                          
                          Text("Sign up")
                              .font(.custom(sansRegular, fixedSize: 20))
                            .frame(maxWidth: .infinity,alignment: .leading)
                              
                          Image(systemName: "arrow.right")
                          
                      }
                      .padding(.horizontal)
                      .scaleEffect(isLast ? 1 : 0.001)
                      .frame(height: isLast ? nil : 0)
                      .opacity(isLast ? 1 : 0)
                  }
                      .foregroundColor(.white)
                      .frame(width:isLast ? size.width / 1.5 : 55,height:isLast ? 50 :  55)
                       .background{
                        
                           RoundedRectangle(cornerRadius: 20, style: .continuous)
                               .fill(Color("Blue"))
                       }
                       .onTapGesture {
                           
                           if currentIndex == intros.count{
                               
                               showHome = true
                           }
                           else{
                               
                               currentIndex += 1
                           }
                          
                       }
                       .offset(y:isLast ? -40 : -70)
                       .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: isLast)
              }
              .overlay(alignment: .bottom) {
                  
                  HStack(spacing:10){
                      
                        Text("Already have an account?")
                          .font(.custom(sansMedium, fixedSize: 15))
                          .foregroundColor(.gray)
                      
                      
                      Button("Login"){
                          
                          
                      }
                      .font(.custom(sansRegular, fixedSize: 20))
                      .foregroundColor(.black)
                  }
                  .offset(y:isLast ? -12 : 120)
                  .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(1), value: isLast)

                  
              }
              .offset(y:workThrought ? 0 : size.height)
        }
    
        
    }
    @ViewBuilder
    func Indicators ()->some View{
        
        
        HStack(spacing: 15) {
            
            ForEach(intros.indices ,id:\.self){index in
                
                Circle()
                    .fill(.gray.opacity(0.3))
                    .frame(width: 8,height: 8)
                    .overlay {
                        
                        if currentIndex == index{
                            
                            Circle()
                                .fill(Color("Blue"))
                                .frame(width: 8,height: 8)
                                .matchedGeometryEffect(id: "INDI", in: animation)
                        }
                    }
            }
            
        }
        .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: currentIndex)
        
    }
    @ViewBuilder
    func ScreenView(size : CGSize,index : Int)-> some View{
        
        let intros = intros[index]
        
        VStack(spacing: 30) {
            
            Text(intros.title)
                .font(.custom(sansRegular, fixedSize: 28))
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.custom(sansRegular, fixedSize: 15))
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .padding(.top,20)
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                
            Image(intros.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                
            
                
            
        }
        .offset(y:-30)
        
        
    }
    
    
    @ViewBuilder
    func Welcome(size : CGSize,index : Int)-> some View{
        
     
        
        VStack(spacing: 30) {
            
            
        Image("Welcome")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 250)
            .offset(x:-size.width * CGFloat(currentIndex - index))
            .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            
            Text("Welcome")
                .font(.custom(sansRegular, fixedSize: 28))
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.custom(sansRegular, fixedSize: 15))
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .padding(.top,20)
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
          
            
                
            
        }
        .offset(y:-30)
        
        
    }
    
    
    
    
    @ViewBuilder
    func navBar ()->some View{
          
        let isLast = currentIndex == intros.count
        
        HStack{
            
            Button {
                
                if currentIndex > 0 {
                    
                    currentIndex -= 1
                }
                else{
                    
                    workThrought.toggle()
                }
                
            } label: {
             
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(Color("Blue"))
                
            }
            
            Spacer()
            
            Button("Skip"){
                
                
                currentIndex = intros.count
                
            }
            .foregroundColor(Color("Blue"))
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
            
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .offset(y:workThrought ? 0 : -120)
        
    }
    @ViewBuilder
    func introScreen ()->some View{
        
        GeometryReader{
            
            let size = $0.size
         
            VStack(spacing: 15) {
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width,height: size.height / 2)
                
                Text("Clear Head".uppercased())
                    .font(.custom(sansRegular, fixedSize: 20))
                    .kerning(1.5)
                    .padding(.top,55)
                
                
                  Text(dummyText)
                    .font(.custom(sansMedium, fixedSize: 15))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                
            Text("Let's Start")
                    .font(.custom(sansSemibold, size: 23))
                    .foregroundColor(.white)
                    .padding(.vertical,13)
                    .padding(.horizontal)
                    .background{
                     
                        Capsule()
                            .fill(Color("Blue"))
                    }
                    .onTapGesture {
                        workThrought.toggle()
                    }
                
            }
            .offset(y:workThrought ? -size.height : 0)
        }
        .ignoresSafeArea()
        
    }
        
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct sampleHome : View{
    
    var body: some View{
        
        NavigationStack{
            
            Text("Home")
                .navigationTitle("Home")
        }
    }
}
