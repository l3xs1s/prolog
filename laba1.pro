accessory(1, 'Power Unit', "6 PIN", 'Cougar', 2012).
accessory(2, 'GPU', "6 PIN", 'NVidia', 2019).
accessory(3, 'CPU', "LGA 2011", 'Intel', 2015).

conInterface('Power Unit','8 PIN').
conInterface('GPU', 'PCI Express').
conInterface('CPU', 'LGA 2011').

additionalSlots('Power Unit', '4 PIN').
additionalSlots('GPU', '6 PIN').
additionalSlots('CPU').

product('Power Unit', 10000).
product('GPU', 16000).
product('CPU', 13000).

iscomparable(Accessory1, Accessory2) :- accessory(ID1,Accessory1, Conn1, Company1, Year1), accessory(ID2,Accessory2, Conn2, Company2, Year2), Conn1 = Conn2.

finalsumm(Product1, Product2, Product3) :- product(Product1, Price1), product(Product2, Price2), product(Product3, Price3), write(Price1+Price2+Price3).

whichisolder(Accessory1, Accessory2) :- accessory(ID1,Accessory1, Conn1, Company1, Year1), accessory(ID2,Accessory2, Conn2, Company2, Year2), Year1 < Year2, write('1st accessory is older').