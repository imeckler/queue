module Queue exposing (
  Queue,
  empty,
  push,
  pop,
  isEmpty,
  length,
  map,
  toList
  )

{-| Just a simple queue data type.

# Type
@docs Queue

# Construction
@docs empty, push

# Inspection
@docs pop

# Utilities
@docs isEmpty, length, map, toList
-}

import List exposing ((::))
import Queue.Internal as I exposing (Queue(Queue))

{-| A queue is a sequence supporting O(1) appending (`push`) of a new
    element to the back and amortizsed O(1) removal of the element at the
    front (`pop`). -}
type alias Queue a = I.Queue a

{-| An empty queue, ready for pushin'. -}
empty : Queue a
empty = Queue [] []

{-| Put the given element at the back of the given queue. O(1). -}
push : a -> Queue a -> Queue a
push x (Queue f b) = (Queue f (x::b))

{-| Get the first element of the queue and the queue with the first element
    removed. Returns nothing if the queue is empty. Amortized O(1). -}
pop : Queue a -> Maybe (a, Queue a)
pop (Queue f b) =
  case f of
    (x :: xs) ->
      Just (x, Queue xs b)

    [] ->
      case b of
        [] ->
          Nothing 

        _  -> 
          case List.reverse b of
            (x :: f') -> Just (x, Queue f' [])
            [] -> Debug.crash "Impossible!"

{-| -}
isEmpty : Queue a -> Bool
isEmpty q = case q of
  Queue [] [] -> True
  _           -> False

{-| -}
length : Queue a -> Int
length (Queue f b) = List.length f + List.length b

{-| -}
map : (a -> b) -> Queue a -> Queue b
map g (Queue f b) = Queue (List.map g f) (List.map g b)

{-| A list consisting of the elements in the order in which they were put into the
    queue (i.e., "front to back"). -}
toList : Queue a -> List a
toList (Queue f b) = f ++ List.reverse b

