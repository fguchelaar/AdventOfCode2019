//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

struct Reaction {
    var inputs: [String: Int]
    var output: String
    var amount: Int
}

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
//                if times % reaction.amount != 0 {
                    times += 1
//                }

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

public class Puzzle {

    let reactions: [Reaction]
    public init(input: String) {
        self.reactions =
            input.array(separatedBy: .newlines, using: Puzzle.parse(reaction:))
    }

    class func parse(reaction: String) -> Reaction {
        let parts = reaction
            .components(separatedBy: CharacterSet(charactersIn: ", =>"))
            .filter { !$0.isEmpty }

        let inputs = stride(from: 0, to: parts.count-2, by: 2)
            .reduce(into: [String: Int]()) {
                $0[parts[$1+1]] = Int(parts[$1])!
        }

        let output = parts.last!
        let amount = Int(parts.suffix(2).first!)!

        return Reaction(inputs: inputs, output: output, amount: amount)
    }



    public func part1() -> Int {
        let factory = NanoFactory(reactions: reactions)
        factory.requestFuel(amount: 1)
        return factory.requested["ORE"]!
    }

    public func part2() -> Int {

//        if true {
//            let factory = NanoFactory(reactions: reactions)
//            factory.requestFuel(amount: 1)
//            print(factory.generated)
//        }
//
//        if true {
//            let factory = NanoFactory(reactions: reactions)
//            factory.requestFuel(amount: 2)
//            print(factory.generated)
//        }
//
//        return -1
//
//


        var min = 1
        var max = 1_000_000_000_000
        var guess = max
        while min != max {
            let factory = NanoFactory(reactions: reactions)
            guess = (min + max) / 2
            factory.requestFuel(amount: guess)
            let ore = factory.requested["ORE"]!


            print("fuel: \(guess): \(ore)")

            if ore < 1_000_000_000_000 {
                min = guess + 1
            } else {
                max = guess
            }
        }
        return guess

        //
        //
        //        let factory = NanoFactory(reactions: reactions)
        //        var fuelCount = 0
        //        while factory.requested["ORE", default: 0] < 1_000_000_000_000 {
        //            factory.requestFuel(amount: 1000)
        //            fuelCount += 1000
        //            let ore = factory.requested["ORE"]!
        //            let ratio = Double(ore) / Double(fuelCount)
        //            print("after \(fuelCount): \(ore). Ratio: \(ratio)")
        //        }
        //        return fuelCount


        //        let factory = NanoFactory(reactions: reactions)
        //        var fuelCount = 0
        //        repeat {
        //            factory.requestFuel(amount: 1)
        //            fuelCount += 1
        //        } while factory.generated.count > 0
        //
        //        let ore = factory.requested["ORE"]!
        //        fuelCount = (1_000_000_000_000 / ore) * fuelCount
        //        factory.requested["ORE"] = (1_000_000_000_000 / ore) * ore
        //        while factory.requested["ORE"]! < 1_000_000_000_000 {
        //            factory.requestFuel(amount: 1)
        //            fuelCount += 1
        //        }
        //        return fuelCount-1
    }
}
