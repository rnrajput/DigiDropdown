// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct  DigiDropdown: View {
    let options: [String]
    var menuWdith: CGFloat  =  150
    var buttonHeight: CGFloat  =  50
    var maxItemDisplayed: Int  =  3
    @Binding  var selectedOptionIndex: Int
    @Binding  var showDropdown: Bool
    @State  private  var scrollPosition: Int?
    public init(options: [String], menuWdith: CGFloat, buttonHeight: CGFloat, maxItemDisplayed: Int, selectedOptionIndex: Binding<Int>, showDropdown: Binding<Bool>, scrollPosition: Int? = nil) {
        self.options = options
        self.menuWdith = menuWdith
        self.buttonHeight = buttonHeight
        self.maxItemDisplayed = maxItemDisplayed
        _selectedOptionIndex = selectedOptionIndex
        _showDropdown = showDropdown
        self.scrollPosition = scrollPosition
    }
    
    public var body: some  View {
        
        VStack {
            
            if #available(macOS 12.0, *) {
                VStack(spacing: 0) {
                    if (showDropdown) {
                        let scrollViewHeight: CGFloat  = options.count > maxItemDisplayed ? (buttonHeight*CGFloat(maxItemDisplayed)) : (buttonHeight*CGFloat(options.count))
                        ScrollView {
                            if #available(macOS 11.0, *) {
                                LazyVStack(spacing: 0) {
                                    ForEach(0..<options.count, id: \.self) { index in
                                        Button(action: {
                                            withAnimation {
                                                selectedOptionIndex = index
                                                showDropdown.toggle()
                                            }
                                            
                                        }, label: {
                                            HStack {
                                                Text(options[index])
                                                Spacer()
                                                if (index == selectedOptionIndex) {
                                                    Image(systemName: "checkmark.circle.fill")
                                                    
                                                }
                                            }
                                            
                                        })
                                        .padding(.horizontal, 20)
                                        .frame(width: menuWdith, height: buttonHeight, alignment: .leading)
                                        
                                    }
                                }
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                        .frame(height: scrollViewHeight)
                        .onAppear {
                            scrollPosition = selectedOptionIndex
                        }
                        
                    }
                    // selected item
                    Button(action: {
                        withAnimation {
                            showDropdown.toggle()
                        }
                    }, label: {
                        HStack(spacing: nil) {
                            Text(options[selectedOptionIndex])
                            Spacer()
                            if #available(macOS 11.0, *) {
                                Image(systemName: "chevron.up")
                                    .rotationEffect(.degrees((showDropdown ?  -180 : 0)))
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                    })
                    .padding(.horizontal, 20)
                    .frame(width: menuWdith, height: buttonHeight, alignment: .leading)
                    
                }
                .foregroundStyle(Color.white)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
            } else {
                // Fallback on earlier versions
            }
            
        }
        .frame(width: menuWdith, height: buttonHeight, alignment: .bottom)
        .zIndex(100)
        
    }
}
