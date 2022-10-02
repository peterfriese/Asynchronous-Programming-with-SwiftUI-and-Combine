/*:
 [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
 
 # Using async/await
 
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
 
 This implementation makes use of async/await (available in Swift 5.5) to execute longer running code asynchronously.
 */

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func makeSandwich(bread: String, ingredients: [String], condiments: [String]) async -> String {
  sandwichMakerSays("Preparing your sandwich...")
  
  let toasted = await toastBread(bread)
  let sliced = await slice(ingredients)
  
  sandwichMakerSays("Spreading \(condiments.joined(separator: ", and ")) om \(toasted)")
  sandwichMakerSays("Layering \(sliced.joined(separator: ", "))")
  sandwichMakerSays("Putting lettuce on top")
  sandwichMakerSays("Putting another slice of bread on top")
  
  return "\(ingredients.joined(separator: ", ")), \(condiments.joined(separator: ", ")) on \(toasted)"
}

func toastBread(_ bread: String) async -> String {
  sandwichMakerSays("Toasting the bread... Standing by...")
  await Task.sleep(5_000_000_000)
  return "Crispy \(bread)"
}

func slice(_ ingredients: [String]) async -> [String] {
  var result = [String]()
  for ingredient in ingredients {
    sandwichMakerSays("Slicing \(ingredient)")
    await Task.sleep(1_000_000_000)
    result.append("sliced \(ingredient)")
    
  }
  return result
}

let clock = ContinuousClock()

sandwichMakerSays("Hello to Cafe Async, where we execute your order in asynchronously.")
sandwichMakerSays("Please place your order.")

Task {
  let time = await clock.measure {
    let sandwich = await makeSandwich(bread: "Rye", ingredients: ["Cucumbers", "Tomatoes"], condiments: ["Mayo", "Mustard"])
    customerSays("Hmmm.... this looks like a delicious \(sandwich) sandwich!")
    print("The end.")
  }
  print("Making this sandwich took \(time)")
}


//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

