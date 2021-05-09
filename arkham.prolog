:- module(arkham_main).
:- load_test_files([]).

:- set_prolog_flag(double_quotes,codes).

% TODO these are still handling cards on an individual basis... But we're getting somewhere.

sentence([effect(Dir,Qty,Pool)]) -->
    pool_verb(Dir,Pool),s,
    quantity(Qty,Nos),s,
    pool_token(Pool,Nos),p,
    !.

sentence([K,effect(Dir1,Qty,pool(T,P1)),effect(Dir2,Qty,pool(T,P2))]) -->
    keywords([K]),nl,
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

% Keywords
keywords([keywords(fast,window(W))]) --> fast,p,s,window(W),p.

window(W) --> "play",s,optional_only,"during",s,window_words(W).
window_words(your_turn) --> "your turn".

fast--> "fast".

optional_only --> "only",s,!.
optional_only --> [],!.

%% Action Keywords (<b>Fight.</b>, e.g.)
action_keyword(Action) --> "<b>", action_word(Action), (".";""), "</b>".

action_word(fight) --> "fight",!.
action_word(evade) --> "evade",!.

% Token Pools
token_pool(damage,_,health_pool).
token_pool(horror,_,sanity_pool).
token_pool(clue,singular,clue_pool).
token_pool(clues,plural,clue_pool).
token_pool(resource,singular,resource_pool).
token_pool(resources,plural,resource_pool).

% Chaos Tokens

chaos_token(skull) --> "[skull]".
chaos_token(cultist) --> "[cultist]".
chaos_token(elder_thing) --> "[elder_thing]".
chaos_token(tablet) --> "[tablet]".
chaos_token(auto_fail) --> "[auto_fail]".
chaos_token(elder_sign) --> "[elder_sign]".
