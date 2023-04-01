/*: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
 
 # Publishers and Subscribers
 
 **Publishers** and **subscribers** are a key concept of Combine.
 
 - A `Publisher` emits values over time, and delivers them to one or more subscribers
 - A `Subscriber` receives a stream of elements from a publisher
 */

import Foundation
import Combine

/*:
 `Just` publishes _just_ one value and then completes.
 */
Just(42)

/*:
 **Note** that a publisher will only start publishing once there is a subscription.
 Here we're adding `sink`, which is a generic subscriber, and then print the received value.
 */
Just(42)
  .print()
  .sink { value in
    print("Received \(value)")
  }

print("---")

/*:
 A collectiom can be turned into a publisher by invoking `.publisher` on it.
 */
["Pepperoni", "Mushrooms", "Onions", "Sausage", "Bacon", "Extra cheese", "Black olives", "Green peppers"].publisher
  .sink { topping in
    print("\(topping) is a favourite topping for pizza")
  }

/*:
 `String` is a collection, so using `.publisher` will emit all the characters in the string as individual values, which might not be what you were expecting.
 */
"Combine".publisher
  .sink { value in
    print("Hello \(value)")
  }

/*:
 If you want to publish a single string, use `Just` instead.
 */
Just("Combine")
  .sink { value in
    print("Hello \(value)")
  }

//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
