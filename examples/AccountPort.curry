-- Concurrent object-oriented programming in Curry with ports:
-- a bank account implemented as an object waiting for messages of type
-- Deposit a, Withdraw a, Balance b, or Exit:

import Network.Ports

data Message = Deposit Int | Withdraw Int | Balance Int | Exit

account :: Int -> [Message] -> Bool
account _ []                 =  True
account _ (Exit       : _ )  =  True
account n (Deposit  a : ms)  =  account (n+a) ms
account n (Withdraw a : ms)  =  account (n-a) ms
account n (Balance  b : ms)  =  b=:=n & account n ms

-- create bank account with a port:
accountServer port = newObject account 0 port

-- goals:
goal1 b = let p free in
          accountServer p
          & send (Deposit 200) p & send (Deposit 50) p & send (Balance b) p
          & send Exit p

-- send a message, append it to the message list, and call the client:
sendClient p msgs msg | send msg p = client p (msgs++[msg])

-- client process for bank account:
client p msgs | send (Balance b) p =
  if b==50 then msgs   -- stop process
           else if b>50 then sendClient p msgs (Withdraw 30)  -- buy
                        else sendClient p msgs (Deposit 70)   -- work
  where b free

goal2 msgs = let p free in
             accountServer p
             & (sendClient  p [] (Deposit 100) =:= msgs -- simulation
                &> send Exit p) -- terminate account server


{-
Example usage:

> pakcs
Prelude> :l AccountPort
accountport> goal1 b  where b free
{b=250} True
accountport> goal2 b  where b free
{b=[Deposit 100,Withdraw 30,Withdraw 30,Deposit 70,Withdraw 30,Withdraw 30]} True

-}
