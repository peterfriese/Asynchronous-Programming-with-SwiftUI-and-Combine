/*:
 [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

 # Asynchronous Completion Handlers
 
 - note: Due to limitations in the current version of the Swift Playgrounds app for macOS, some of the code in this playground will fail to compile. Please open the playground in Xcode 14 on your Mac instead to run the code.
 
 This sample shows how to use Grand Central Dispatch and completion handlers to prepare a sandwich.
 
 The steps to prepare a sandwich are:
 * toasting two slices of bread
 * slicing the ingredients (e.g. cucumbers, tomatoes) for the sandwich
 * spreading condiments on the bread
 * layering the ingredients on top of one slice of bread
 * putting a leaf of lettuce on top
 * putting another slice of bread on top
 
 Some of these steps might take a while, for example toasting the bread or slicing the ingredients.

 Completion handlers are a common way to deal with asynchronous code. They are typically implemented using (trailing) closures.
 This example uses `DispatchQueue` to execute long-running conde asynchronously on a background thread.
 */

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func makeSandwich(bread: String, ingredients: [String], condiments: [String], completion: @escaping (String) -> Void) {
  sandwichMakerSays("Preparing your sandwich...")
  
  toastBread(bread) { toasted in
    slice(ingredients) { sliced in
      sandwichMakerSays("Spreading \(condiments.joined(separator: ", and ")) om \(toasted)")
      sandwichMakerSays("Layering \(sliced.joined(separator: ", "))")
      sandwichMakerSays("Putting lettuce on top")
      sandwichMakerSays("Putting another slice of bread on top")
      
      completion("\(ingredients.joined(separator: ", ")), \(condiments.joined(separator: ", ")) on \(toasted)")
    }
  }
  print("This code will be executed *before* the bread is toasted and the ingredients are sliced.")
}

func toastBread(_ bread: String, completion: @escaping (String) -> Void) {
  DispatchQueue.global().async {
    sandwichMakerSays("Toasting the bread... Standing by...", waitFor: 5)
    completion("Crispy \(bread)")
  }
}

func slice(_ ingredients: [String], completion: @escaping ([String]) -> Void) {
  DispatchQueue.global().async {
    let result = ingredients.map { ingredient in
      sandwichMakerSays("Slicing \(ingredient)", waitFor: 1)
      return "sliced \(ingredient)"
    }
    completion(result)
  }
}

sandwichMakerSays("Hello to Cafe Complete, where we handle your order with care.")
sandwichMakerSays("Please place your order.")

let clock = ContinuousClock()
let start = clock.now
makeSandwich(bread: "Rye", ingredients: ["Cucumbers", "Tomatoes"], condiments: ["Mayo", "Mustard"]) { sandwich in
  customerSays("Hmmm.... this looks like a delicious \(sandwich) sandwich!")
  
  let time = clock.now - start
  print("Making this sandwich took \(time)")
}

print("The end.") // notice how this code will be executed **before** the sandwich has been delivered to the customer!

//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

