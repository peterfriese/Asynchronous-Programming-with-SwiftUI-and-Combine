/*:
 [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
 
 # Completion Handlers
 
 - note: Due to limitations in the current version of the Swift Playgrounds app for macOS, some of the code in this playground will fail to compile. Please open the playground in Xcode 14 on your Mac instead to run the code.
 
 This sample shows how to use completion handlers to prepare a sandwich.
 
 The steps to prepare a sandwich are:
 * toasting two slices of bread
 * slicing the ingredients (e.g. cucumbers, tomatoes) for the sandwich
 * spreading condiments on the bread
 * layering the ingredients on top of one slice of bread
 * putting a leaf of lettuce on top
 * putting another slice of bread on top
 
 Some of these steps might take a while, for example toasting the bread or slicing the ingredients.
 
 Completion handlers are a common way to deal with asynchronous code. They are typically implemented using (trailing) closures. Note that, in this sample, we don't execute any part of the code asynchronously. The completion handlers in this sample are merely used to structure the way the individual parts of the app play together. Instead of calling a function and then receiving its return value, the code in this sample uses completion handlers to be _called back_ once the code in the called function has completed.
 
 To actually make use of asynchronous capabilities, we need to make sure the code in the called functions runs asynchronously. To see an example for how this can be achieved, see [Asynchronous Completion Handlers](Asynchronous%20Completion%20Handlers).
 */

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// This is the main algorithm for creating a sandwich. Call it with a bread, some ingredients, and condiments of your liking.
/// - Parameters:
///   - bread: The type of bread you want your sandwich to be based on.
///   - ingredients: A list of ingredients you want to put on your sandwich.
///   - condiments: The condiments you want to be spread on the slices of bread.
///   - completion: The completion handler that will be called at the end of the sandwich making process.
func makeSandwich(bread: String, ingredients: [String], condiments: [String], completion: (String) -> Void) {
  sandwichMakerSays("Preparing your sandwich...")
  
  toastBread(bread, completion: { toasted in
    print("\(bread) is now \(toasted)")
  })
  print("This code will be executed before the bread is toasted")
  
  toastBread(bread) { toasted in
    print("\(bread) is now \(toasted)")
  }
  
  toastBread(bread) { toasted in
    slice(ingredients) { sliced in
      sandwichMakerSays("Spreading \(condiments.joined(separator: ", and ")) om \(toasted)")
      sandwichMakerSays("Layering \(sliced.joined(separator: ", "))")
      sandwichMakerSays("Putting lettuce on top")
      sandwichMakerSays("Putting another slice of bread on top")
      
      completion("\(ingredients.joined(separator: ", ")), \(condiments.joined(separator: ", ")) on \(toasted)")
    }
  }
}

/// This function toasts your bread. Not really, but you get the point.
/// - Parameters:
///   - bread: The type of bread to be used.
///   - completion: The completion handler that will be called at the end of the toasting process.
func toastBread(_ bread: String, completion: (String) -> Void) {
  sandwichMakerSays("Toasting the bread... Standing by...", waitFor: 5)
  completion("Crispy \(bread)")
}

/// This function slices the ingredients for your sandwich. Kind of.
/// - Parameters:
///   - ingredients: A list of ingredients.
///   - completion: The completin handler that will be called when all ingredients have been sliced.
func slice(_ ingredients: [String], completion: ([String]) -> Void) {
  let result = ingredients.map { ingredient in
    sandwichMakerSays("Slicing \(ingredient)", waitFor: 1)
    return "sliced \(ingredient)"
  }
  completion(result)
}

//: The main program follows

sandwichMakerSays("Hello to Cafe Complete, where we handle your order with care.")
sandwichMakerSays("Please place your order.")

// We're using a `ContinuousClock` to determine how long it took to make the sandwich.
let clock = ContinuousClock()
let time = clock.measure {
  makeSandwich(bread: "Rye", ingredients: ["Cucumbers", "Tomatoes"], condiments: ["Mayo", "Mustard"]) { sandwich in
    customerSays("Hmmm.... this looks like a delicious \(sandwich) sandwich!")
  }
}

// This should be roughly 7 seconds (5 for toasting, and 1 for each ingredient we sliced)
print("Making this sandwich took \(time)")

print("The end.")

//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
