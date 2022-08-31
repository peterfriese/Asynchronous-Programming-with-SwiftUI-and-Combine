/*:
 [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
 
 # Synchronous Code
 
 This sample shows how to use synchronous code to prepare a sandwich.
 
 The steps to prepare a sandwich are:
 * toasting two slices of bread
 * slicing the ingredients (e.g. cucumbers, tomatoes) for the sandwich
 * spreading condiments on the bread
 * layering the ingredients on top of one slice of bread
 * putting a leaf of lettuce on top
 * putting another slice of bread on top
 
 Some of these steps might take a while, for example toasting the bread or slicing the ingredients. In this implementation, the sandwich maker will execute all steps serially, one after the other. This means they will stand by while waiting for the bread to be toasted (which, in this example, takes five seconds).
 
 This is what we call **blocking**: no other part of the app running on the same thread will be able to execute until the respective call has completed.
 
 In the other implementations, we will look at some features such as completion handlers and Swift's support for async/await to see how they can help to deal with asynchronous code.
 */

import Foundation

/// This is the main algorithm for creating a sandwich. Call it with a bread, some ingredients, and condiments of your liking.
/// - Parameters:
///   - bread: The type of bread you want your sandwich to be based on.
///   - ingredients: A list of ingredients you want to put on your sandwich.
///   - condiments: The condiments you want to be spread on the slices of bread.
/// - Returns: The finished sandwich.
func makeSandwich(bread: String, ingredients: [String], condiments: [String]) -> String {
  sandwichMakerSays("Preparing your sandwich...")
  
  let toasted = toastBread(bread)
  let sliced = slice(ingredients)
  
  sandwichMakerSays("Spreading \(condiments.joined(separator: ", and ")) on \(toasted)")
  sandwichMakerSays("Layering \(sliced.joined(separator: ", "))")
  sandwichMakerSays("Putting lettuce on top")
  sandwichMakerSays("Putting another slice of bread on top")
  
  return "\(ingredients.joined(separator: ", ")), \(condiments.joined(separator: ", ")) on \(toasted)"
}

/// This function toasts your bread. Not really, but you get the point.
/// - Parameter bread: The type of bread to be used.
/// - Returns: The toasted bread.
func toastBread(_ bread: String) -> String {
  sandwichMakerSays("Toasting the bread... Standing by...", waitFor: 5)
  return "Crispy \(bread)"
}

/// This function slices the ingredients for your sandwich. Kind of.
/// - Parameter ingredients: A list of ingredients.
/// - Returns: A list of slices ingredients.
func slice(_ ingredients: [String]) -> [String] {
  let result = ingredients.map { ingredient in
    sandwichMakerSays("Slicing \(ingredient)", waitFor: 1)
    return "sliced \(ingredient)"
  }
  return result
}

//: The main program follows

sandwichMakerSays("Hello to Cafe Synchronous, where we execute your order serially.")
sandwichMakerSays("Please place your order.")

// We're using a `ContinuousClock` to determine how long it took to make the sandwich.
let clock = ContinuousClock()
let time = clock.measure {
  let sandwich = makeSandwich(bread: "Rye", ingredients: ["Cucumbers", "Tomatoes"], condiments: ["Mayo", "Mustard"])
  customerSays("Hmmm.... this looks like a delicious \(sandwich) sandwich!")
}

// This should be roughly 7 seconds (5 for toasting, and 1 for each ingredient we sliced)
print("Making this sandwich took \(time)")

//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

