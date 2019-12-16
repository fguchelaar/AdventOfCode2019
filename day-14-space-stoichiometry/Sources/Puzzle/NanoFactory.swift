//
//  NanoFactory.swift
//  
//
//  Created by Frank Guchelaar on 16/12/2019.
//

import Foundation

class NanoFactory {
    
    let reactions: [Reaction]
    init(reactions: [Reaction]) {
        self.reactions = reactions
    }
    
    var requested = [String: Int]()
    var generated = [String: Int]()
    
    func requestFuel(amount: Int) {
        requested["FUEL"] = 1 * amount
        
        while !requested.allSatisfy { $0.key == "ORE" } {
            
            let request = requested.first { $0.key != "ORE" }!
            
            let needed = request.value
            let leftOver = generated[request.key, default: 0] - needed
            
            if leftOver >= 0 {
                generated[request.key] = leftOver
                requested.removeValue(forKey: request.key)
            } else {
                generated[request.key] = 0
                
                let reaction = reactions.first { $0.output == request.key }!
                
                var times = abs(leftOver) / reaction.amount
                if times == 0 {
                    times = 1
                } else if (times * reaction.amount) % leftOver != 0 {
                    times += 1
                }
                
                for input in reaction.inputs {
                    
                    let leftOver2 = generated[input.key, default: 0] - (input.value * times)
                    if leftOver2 >= 0 {
                        generated[input.key] = leftOver2
                    } else {
                        generated[input.key] = 0
                        requested[input.key, default: 0] += abs(leftOver2)
                    }
                }
                
                generated[request.key, default: 0] += leftOver + (reaction.amount * times)
                
                if generated[request.key, default: 0] < 0 {
                    requested[request.key, default: 0] = abs(leftOver) - (reaction.amount * times)
                    generated[request.key] = 0
                } else {
                    requested[request.key, default: 0] -= (reaction.amount * times)
                    if requested[request.key, default: 0] <= 0 {
                        requested.removeValue(forKey: request.key)
                    }
                }
            }
        }
        generated = generated.filter { $0.value != 0 }
    }
}
