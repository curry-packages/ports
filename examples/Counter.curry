-- Distributed programming in Curry:
-- a counter server reacting on messages of type (Set v), Inc, or (Get x):

import Network.Ports

-- the counter implemented as a concurrent object:
data CounterMessage = Set Int | Inc | Get Int

counter :: Int -> [CounterMessage] -> Bool
counter _ (Set v : ms) = counter v ms
counter n (Inc   : ms) = counter (n+1) ms
counter n (Get v : ms) = v=:=n & counter n ms
counter _ []           = True

-- creating the counter object as a server:
counterServer = newNamedObject counter 0 "counter"

-- a counter client:
cc msg = do
  port <- connectPort "counter@localhost"
  doSend msg port

cinc = cc Inc

cset n = cc (Set n)

cget x = cc (Get x)

