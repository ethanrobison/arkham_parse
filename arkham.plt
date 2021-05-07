:- load_files('arkham').
:- load_files('parse').

:- begin_tests(gain_lose_tokens).

test(gain_1_res):-
    sentence(effect(increase,1,resource_pool),
    [gain,1,resource],
    []).

:- end_tests(gain_lose_tokens).

:- begin_tests(basic_functions).
test(empty_string):-
    string_to_token("", '').
test(number_ten):-
    string_to_token("10", 10).
test(word_ten):-
    string_to_token("ten", ten).

test(no_newline):-
    extract_nl("foo", ["foo"]).
test(yes_newline):-
    extract_nl("\nfoo", ["\n", "foo"]).
test(two_newline):-
    extract_nl("\n\n", ["\n","\n"]).

test(is_quantity_1):- is_quantity(1,singular).
test(is_quantity_0):- is_quantity(0,plural).
test(is_quantity_5):- is_quantity(5,plural).

:- end_tests(basic_functions).

% events
:- begin_tests(events_text,[blocked(bad_pred)]).
test(emergency_cache_text):-
    %parse_card("Gain 3 resources.", [gain, 3, resources]).
    false.
test(hot_streak_text):-
    % parse_card("Gain 10 resources.", [gain, 10, resources]).
    false.
test(charisma_text):-
    % parse_card("Permanent.\nYou have 1 additional ally slot.",
    % [permanent, '', you, have, 1, additional, ally, slot]).
    false.
:- end_tests(events_text).
