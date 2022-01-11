-- Taky tu nic není, sem budu jen dávat to co vytvořím.
local i = 0
local function Test() -- Tvoření funkce Test.
  print("Hello World!") -- Kód který se spustí s funkcí.
end

for i, 5, i += 1 do -- For loop.
  Test() -- Napíše to 6x "Hello World!" do konzole.
end

while i < 6 do -- While loop.
  Test() -- Napíše to do konzole 5x "Hello World!"
end
