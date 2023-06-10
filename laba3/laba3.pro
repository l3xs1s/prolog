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
    length : (A*) -> integer N.
    el_sum : (real* List) -> real Sum.
    laverage : (real* List) -> real Average determ.
    max : (real* List, real Max [out]) nondeterm.
    min : (real* List, real Min [out]) nondeterm.

clauses
    length([]) = 0.
    length([_ | T]) = length(T) + 1.

    el_sum([]) = 0.
    el_sum([H | T]) = el_sum(T) + H.

    laverage(L) = el_sum(L) / length(L) :-
        length(L) > 0.

    max([Max], Max).

    max([H1, H2 | T], Max) :-
        H1 >= H2,
        max([H1 | T], Max).

    max([H1, H2 | T], Max) :-
        H1 <= H2,
        max([H2 | T], Max).

    min([Min], Min).

    min([H1, H2 | T], Min) :-
        H1 <= H2,
        min([H1 | T], Min).

    min([H1, H2 | T], Min) :-
        H1 >= H2,
        min([H2 | T], Min).

class predicates
    print_list : (integer*) nondeterm.
    print_list : (string*) nondeterm.
    print_list : (main::pcAcessoryDb*) nondeterm.
    accessory_connections : (string AccessoriesName) -> main::pcAcessoryDb* AccCon nondeterm.
    pricesum : () -> real Sum determ.
    pricemax : () -> real Max nondeterm.
    pricemin : () -> real Min nondeterm.

clauses
    accessory_connections(AccessoriesName) = AccCon :-
        accessory(Id, _, Connection, _, _),
        !,
        AccCon = [ accessory(Id, Name, Connection, Manufacturer, Year) || accessory(Id, Name, Connection, Manufacturer, Year) ].

    print_list([X | Y]) :-
        write(X),
        nl,
        print_list(Y).

    pricesum() = Sum :-
        Sum = el_sum([ Price || product(_, Price) ]).

    pricemax() = Res :-
        max([ Price || product(_, Price) ], Max),
        Res = Max,
        !.
    pricemin() = Res :-
        min([ Price || product(_, Price) ], Min),
        Res = Min,
        !.

clauses
    run() :-
        file::consult("../consultfile.txt", pcAcessoryDb),
        fail.
    run() :-
        PList = accessory_connections("6PIN"),
        write(PList),
        nl,
        write("Printing list..."),
        nl,
        print_list(PList),
        write("Printing finished"),
        nl,
        fail.
    run() :-
        write("Price sumary:", pricesum()),
        nl,
        write("Max price:", pricemax()),
        nl,
        write("Min prce:", pricemin()),
        nl,
        fail.
    run() :-
        stdio::write("End test\n").

end implement main

goal
    console::runUtf8(main::run).
