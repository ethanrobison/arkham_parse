:- use_module('parse').

:- begin_tests(basic_functions).
test(empty_string):-
    string_to_token("", '').
test(number_ten):-
    string_to_token("10", 10).
test(word_ten):-
    string_to_token("ten", ten).

test(is_quantity_1):- is_quantity(1,singular).
test(is_quantity_0):- is_quantity(0,plural).
test(is_quantity_5):- is_quantity(5,plural).

:- end_tests(basic_functions).

:- begin_tests(insertion_and_splitting).

test(insert_between_singleton):- arkham_parse:insert_between(["foo"], "\n", ["foo"]).
test(insert_between_duo):- arkham_parse:insert_between(["foo", "bar"], "\n", ["foo", "\n", "bar"]).
test(insert_between_trio):-
    arkham_parse:insert_between(["foo", "bar", "baz"], "\n", ["foo", "\n", "bar", "\n", "baz"]).

test(split_and_insert_no_match):-
    arkham_parse:split_and_reinsert_character("foo bar baz", "\n", ["foo bar baz"]).
test(split_and_insert_one_match):-
    arkham_parse:split_and_reinsert_character("foo\nbar", "\n", ["foo", "\n", "bar"]).
test(split_and_insert_terminal):-
    arkham_parse:split_and_reinsert_character("foo\n", "\n", ["foo", "\n"]).
test(split_and_insert_prefix):-
    arkham_parse:split_and_reinsert_character("\nfoo", "\n", ["\n", "foo"]).

:- end_tests(insertion_and_splitting).

% events
:- begin_tests(events_text).

test(emergency_cache_text):-
    string_to_tokens("Gain 3 resources.", [gain, 3, resources,'.']).
test(hot_streak_text):-
    string_to_tokens("Gain 10 resources.", [gain, 10, resources,'.']).
test(working_a_hunch_text):-
    string_to_tokens("Fast. Play only during your turn.\nDiscover 1 clue at your location.",
        [fast,'.',play,only,during,your,turn,'.','\n',discover,1,clue,at,your,location,'.']).
test(barricade_text):-
    string_to_tokens("Attach to your location.\nNon-[[Elite]] enemies cannot move into attached location.\n<b>Forced</b> - When an investigator leaves attached location: Discard Barricade.",
        [attach,to,your,location,'.','\n',
        'non-[[elite]]',enemies,cannot,move,into,attached,location,'.','\n',
        '<b>forced</b>','-',when,an,investigator,leaves,attached,'location:',discard,barricade,'.']).
test(backstab_text):-
    string_to_tokens("<b>Fight.</b> This attack uses [agility] instead of [combat]. This attack deals +2 damage.",
        ['<b>fight','.','</b>',this,attack,uses,'[agility]',instead,of,'[combat]','.',this,attack,deals,'+2',damage,'.']).
:- end_tests(events_text).
