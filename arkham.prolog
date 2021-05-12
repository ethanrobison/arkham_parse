:- module(arkham_main).
:- load_test_files([]).

card(K,Es) --> keywords(K),nl,sentences(Es),!.
card([],Es) --> sentences(Es).

sentences([E|T]) --> sentence(E),s,sentences(T),!.
sentences(E) --> sentence(E).

sentence([effect(Dir,Qty,Pool)]) -->
    pool_verb(Dir,Pool),s,
    quantity(Qty,Nos),s,
    pool_token(Pool,Nos),p,
    !.

sentence([effect(Dir1,Qty,pool(T,P1)),effect(Dir2,Qty,pool(T,P2))]) -->
    pool_verb(Dir1,pool(T,P1)),s,
    quantity(Qty,Nos),s,
    pool_token(pool(T,P1),Nos),s,
    pool_area(pool(T,P2)),p,
    {opposite_dir(Dir1,Dir2)},
    !.

% Pools
pool_verb(increase,pool(_,you)) --> "gain",!.
pool_verb(decrease,pool(_,you)) --> "lose",!.
pool_verb(increase,pool(clue,you)) --> "discover",!.

pool_token(P,Nos) --> pool_token_word(P,Nos).
pool_token_word(pool(resource,_),singular)-->"resource".
pool_token_word(pool(resource,_),plural)-->"resources".
pool_token_word(pool(clue,_),singular)-->"clue".
pool_token_word(pool(clue,_),plural)-->"clues".

pool_area(pool(_,location)) --> "at your location".

opposite_dir(increase,decrease).
opposite_dir(decrease,increase).

% Timing Window Keywords
keywords([keywords(fast,window(W))]) --> fast,p,s,window(W),p.

window(W) --> "play",s,optional_only,timing_window(W).

timing_window(during(W)) --> "during",s,window_words(W),!.
timing_window(after(W)) --> "after",s,window_words(W),!.

window_words(your_turn) --> "your turn".
window_words(you_defeat_enemy)--> "you defeat an enemy".

fast--> "fast".

optional_only --> "only",s,!.
optional_only --> [],!.

%% Action Keywords (<b>Fight.</b>, e.g.)
action_keyword(Action) --> "<b>", action_word(Action), (".";""), "</b>".

action_word(fight) --> "fight",!.
action_word(evade) --> "evade",!.

% Chaos Tokens

chaos_token(skull) --> "[skull]".
chaos_token(cultist) --> "[cultist]".
chaos_token(elder_thing) --> "[elder_thing]".
chaos_token(tablet) --> "[tablet]".
chaos_token(auto_fail) --> "[auto_fail]".
chaos_token(elder_sign) --> "[elder_sign]".

% Indentation, punctuation, &c.
s --> " ".
p --> ".".
nl --> "\n".

% Numbers
quantity(1,singular) -->
    digit(D0),
    digits(D),
    { number_codes(1, [D0|D]) }, !.
quantity(Q,plural) -->
    digit(D0),
    digits(D),
    { number_codes(Q, [D0|D]) }.

digits([D|T]) --> digit(D), !, digits(T).
digits([]) --> [].

digit(D) --> [D], { code_type(D,digit) }.
