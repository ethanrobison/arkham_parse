:- module(arkham_main).
:- load_test_files([]).

:- set_prolog_flag(double_quotes,codes).

% "gain 3 resources."

s --> " ".
p --> ".".
card(effect(Dir,Qty,Pool)) -->
    pool_verb(Dir,Qty,Pool),s,
    quantity(Qty,Nos),s,
    pool_token(Pool,Nos),p.

pool_verb(increase,_Qty,_Pool) --> "gain",!.
pool_verb(decrease,_Qty,_Pool) --> "lose",!.

pool_token(P,Nos) --> pool_token_word(P,Nos).
pool_token_word(resource_pool,singular)-->"resource".
pool_token_word(resource_pool,plural)-->"resources".

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

% Action Keywords (<b>Fight.</b>, e.g.)

action_keyword(Action) --> "<b>", action_word(Action), (".";""), "</b>".
action_word(fight) --> "fight",!.
action_word(evade) --> "evade",!.
