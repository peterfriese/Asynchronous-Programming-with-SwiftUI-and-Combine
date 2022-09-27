/*:
 [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

 # Using async let
 
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
 
 This implementation makes use of `async let` to launch several tasks at once. They will be executed in parallel in the background, and the program continues running in the foreground. Once any one of the constants is being awaited (using `await toasted` or `await sliced`), a susspension point is created, allowing the runtime to suspend the asynchronously executing function.
 */

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func makeSandwich(bread: String, ingredients: [String], condiments: [String]) async -> String {
  sandwichMakerSays("Preparing your sandwich...")
  
  async let toasted = toastBread(bread)
  async let sliced = slice(ingredients)
  
  sandwichMakerSays("Spreading \(condiments.joined(separator: ", and ")) om \(await toasted)")
  sandwichMakerSays("Layering \(await sliced.joined(separator: ", "))")
  sandwichMakerSays("Putting lettuce on top")
  sandwichMakerSays("Putting another slice of bread on top")
  
  return "\(ingredients.joined(separator: ", ")), \(condiments.joined(separator: ", ")) on \(await toasted)"
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

sandwichMakerSays("Hello to Cafe Async Let, where we execute your order in parallel.")
sandwichMakerSays("Please place your order.")

Task {
  let time = await clock.measure {
    let sandwich = await makeSandwich(bread: "Rye", ingredients: ["Cucumbers", "Tomatoes"], condiments: ["Mayo", "Mustard"])
    customerSays("Hmmm.... this looks like a delicious \(sandwich) sandwich!")
    print("The end.")
  }
  print("Making this sandwich took \(time)") // prints "Making this sandwich took 5.331491 seconds"
}


//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

