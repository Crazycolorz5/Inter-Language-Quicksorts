module Quicksort where

import Foreign.Marshal.Array
import Foreign.Ptr
import Foreign.Storable
import Data.Word
import Data.Int

foreign export ccall "quickSort" quicksort_Marshalled :: Ptr Int64 -> Word64 -> IO ()
foreign export ccall marshalTest :: Ptr Int64 -> Word64 -> IO ()

quicksort_Marshalled lst len = do
    haskArr <- peekArray (fromIntegral len) lst
    let sortedHaskArr = quicksort haskArr
    pokeArray lst sortedHaskArr

marshalTest lst len = do
    haskArr <- peekArray (fromIntegral len) lst
    pokeArray lst haskArr

{-
quicksort::(Ord a)=>[a]->[a]
quicksort [] = []
quicksort lst = lesser ++ equals ++ greater
    where
        lesser = quicksort $ filter (<(head lst)) $ tail lst
        equals = filter (==(head lst)) $ lst
        greater = quicksort $ filter (>(head lst)) $ tail lst
-}


quicksort::(Ord a)=>[a]->[a]
quicksort lst = quicksort_rec lst [] (\x->x)

quicksort_rec::(Ord a)=>[a]->[a]->([a]->[a])->[a]
quicksort_rec [] acc cont = cont acc
quicksort_rec (x:[]) acc cont = cont (x:acc)
quicksort_rec (x:lst) acc cont = let 
        lessers  = filter (<x) lst
        greaters = filter (>=x) lst
    in quicksort_rec greaters acc (\newAcc->(quicksort_rec lessers (x:newAcc) cont))
