implement main
    open core, stdio, file

domains
    accesoryType = main; additionally.

class facts - pcAcessoryDb
    accessory : (integer Id, string Name, string Connection, string Manufacturer, integer Year).
    conInterface : (string Name, string Connection).
    additionalSlots : (string Name, string AddSlots).
    product : (string Name, integer Price).

class predicates
    iscomparable : (string Accessory1, string Accessory2) nondeterm anyflow.
    finalsumm : (string Product1, string Product2, string Product3, string Product4) nondeterm anyflow.
    whichisolder : (string Accessory1, string Accessory2) nondeterm anyflow.

clauses
    iscomparable(Accessory1, Accessory2) :-
        accessory(_, Accessory1, Conn1, _, _),
        accessory(_, Accessory2, Conn2, _, _),
        Conn1 = Conn2.

    finalsumm(Product1, Product2, Product3, Product4) :-
        product(Product1, Price1),
        product(Product2, Price2),
        product(Product3, Price3),
        product(Product4, Price4),
        write(Price1 + Price2 + Price3 + Price4).

    whichisolder(Accessory1, Accessory2) :-
        accessory(_, Accessory1, _, _, Year1),
        accessory(_, Accessory2, _, _, Year2),
        Year1 < Year2,
        write('1st accessory is older').

clauses
    run() :-
        file::consult("../consultfile.txt", pcAcessoryDb),
        fail.
    run() :-
        iscomparable(A1, A2),
        stdio::write("Accessory ", A1, " comparable with accessory", A2, "\n"),
        fail.

    run() :-
        finalsumm(_P1, _P2, _P3, _P4),
        fail.

    run() :-
        whichisolder(_A1, _A2),
        fail.

    run() :-
        stdio::write("End test\n").

end implement main

goal
    console::runUtf8(main::run).
