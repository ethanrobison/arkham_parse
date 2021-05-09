% TODO why is this directive screwy?
%:- use_module('arkham').

%
:- begin_tests(quantities).

% N.B.: did these this way because bindings were greedily slurping up the "1"
% in "10" and failing if 10/plural were unbound. Sigh.
test(is_0,[true(Nos=plural)]):-
    arkham_main:quantity(0,Nos,"0",[]).
test(is_1, [true(Nos=singular)]):-
    arkham_main:quantity(1,Nos,"1",[]).
test(is_10, [true(Nos=plural)]):-
    arkham_main:quantity(10,Nos,"10",[]).

:- end_tests(quantities).

%
:- begin_tests(chaos_tokens).

test(skull):- arkham_main:chaos_token(skull, "[skull]", []).
test(cultist):- arkham_main:chaos_token(cultist, "[cultist]", []).
test(elder_thing):- arkham_main:chaos_token(elder_thing, "[elder_thing]", []).
test(tablet):- arkham_main:chaos_token(tablet, "[tablet]", []).
test(auto_fail):- arkham_main:chaos_token(auto_fail, "[auto_fail]", []).
test(elder_sign):- arkham_main:chaos_token(elder_sign, "[elder_sign]", []).

:- end_tests(chaos_tokens).

%
:- begin_tests(pools).

test(your_location):-  arkham_main:pool_area(pool(_,location),"at your location",[]).

:- end_tests(pools).

%
:- begin_tests(card_structure).

test(play_during_your_turn, [true(W=during(your_turn))]):-
    arkham_main:window(W, "play during your turn", []).
test(play_during_your_turn_only, [true(W=during(your_turn))]):-
    arkham_main:window(W, "play only during your turn", []).
test(after_you_defeat_an_enemy, [true(W=after(you_defeat_enemy))]):-
    arkham_main:window(W, "play after you defeat an enemy", []).

test(single_sentence):-
    arkham_main:sentence(_E,"gain 3 resources.",[]).
test(two_sentences):-
    arkham_main:sentences(_E,"gain 3 resources. gain 1 resource.",[]).
test(keyword_and_sentence):-
    arkham_main:card(_K,_E,"fast. play during your turn.\ngain 3 resources.",[]).

:- end_tests(card_structure).

%
:- begin_tests(gain_lose_tokens).

test(gain_1_res,[true(E=[effect(increase,1,pool(resource,you))])]):-
    arkham_main:sentence(E,"gain 1 resource.",[]).
test(lose_1_res,[true(E=[effect(decrease,1,pool(resource,you))])]):-
    arkham_main:sentence(E,"lose 1 resource.",[]).
test(singular_plural_fail, [fail]):-
    arkham_main:sentence(_E,"lose 1 resources.",[]).

:- end_tests(gain_lose_tokens).

:- begin_tests(core_events).

test(emergency_cache,[true(E=[effect(increase,3,pool(resource,you))])]):-
    arkham_main:sentence(E,"gain 3 resources.",[]).
test(hot_streak,[true(E=[effect(increase,10,pool(resource,you))])]):-
    arkham_main:sentence(E,"gain 10 resources.",[]).
test(working_a_hunch_effects, [true(Es=[
        effect(increase,1,pool(clue,you)),
        effect(decrease,1,pool(clue,location))])]):-
    arkham_main:card(_K,Es,
        "fast. play only during your turn.\ndiscover 1 clue at your location.",[]).
test(working_a_hunch_keywords, [true(K=[keywords(fast,window(during(your_turn)))])]):-
    arkham_main:card(K,_Es,
        "fast. play only during your turn.\ndiscover 1 clue at your location.",[]).

test(evidence_keywords, [true(K=[keywords(fast,window(after(you_defeat_enemy)))])]):-
    arkham_main:card(K,_Es,
        "fast. play after you defeat an enemy.\ndiscover 1 clue at your location.",[]).
test(evidence_effects, [true(Es=[
        effect(increase,1,pool(clue,you)),
        effect(decrease,1,pool(clue,location))])]):-
    arkham_main:card(_K,Es,
        "fast. play after you defeat an enemy.\ndiscover 1 clue at your location.",[]).

:- end_tests(core_events).
