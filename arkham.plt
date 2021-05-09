% TODO why is this directive screwy?
%:- use_module('arkham').

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

:- begin_tests(chaos_tokens).

test(skull):- arkham_main:chaos_token(skull, "[skull]", []).
test(cultist):- arkham_main:chaos_token(cultist, "[cultist]", []).
test(elder_thing):- arkham_main:chaos_token(elder_thing, "[elder_thing]", []).
test(tablet):- arkham_main:chaos_token(tablet, "[tablet]", []).
test(auto_fail):- arkham_main:chaos_token(auto_fail, "[auto_fail]", []).
test(elder_sign):- arkham_main:chaos_token(elder_sign, "[elder_sign]", []).

:- end_tests(chaos_tokens).

:- begin_tests(gain_lose_tokens).

test(gain_1_res,[true(E=effect(increase,1,resource_pool))]):-
    arkham_main:card(E,"gain 1 resource.",[]).
test(gain_2_res,[true(E=effect(increase,2,resource_pool))]):-
    arkham_main:card(E,"gain 2 resources.",[]).
test(gain_10_res,[true(E=effect(increase,10,resource_pool))]):-
    arkham_main:card(E,"gain 10 resources.",[]).
test(lose_1_res,[true(E=effect(decrease,1,resource_pool))]):-
    arkham_main:card(E,"lose 1 resource.",[]).
test(singular_plural_fail, [fail]):-
    arkham_main:card(_E,"lose 1 resources.",[]).

:- end_tests(gain_lose_tokens).
