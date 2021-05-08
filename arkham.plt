:- use_module('arkham').

:- begin_tests(chaos_tokens).

test(skull):- chaos_token(skull, ['[skull]'], []).
test(cultist):- chaos_token(cultist, ['[cultist]'], []).
test(elder_thing):- chaos_token(elder_thing, ['[elder_thing]'], []).
test(tablet):- chaos_token(tablet, ['[tablet]'], []).
test(auto_fail):- chaos_token(auto_fail, ['[auto_fail]'], []).
test(elder_sign):- chaos_token(elder_sign, ['[elder_sign]'], []).

:- end_tests(chaos_tokens).

:- begin_tests(gain_lose_tokens).

test(gain_1_res):-
    sentence(
        effect(increase,1,resource_pool),
        [gain,1,resource],
        []).

:- end_tests(gain_lose_tokens).
