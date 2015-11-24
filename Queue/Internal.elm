module Queue.Internal (Queue(..)) where

{-| Internal representation of the queue type.

@docs Queue
-}

{-| See [this blog post](http://parametricity.com/posts/2015-02-19-animating.html). -}
type Queue a = Queue (List a) (List a)

