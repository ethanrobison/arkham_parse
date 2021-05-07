:- use_module('parse').

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
