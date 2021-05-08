:- module(arkham_parse,
    [string_to_tokens/2,
    string_to_token/2,
    is_quantity/2]).
:- load_test_files([]).

string_to_tokens(Str, Tokens):-
    string_lower(Str, Lower),
    split_string(Lower, " ", "", Split),
    maplist(extract_periods, Split, Periods),
    flatten(Periods, PeriodFlat),
    maplist(extract_nl, PeriodFlat, Nls),
    flatten(Nls, NlFlat),
    maplist(string_to_token, NlFlat, Tokens).

string_to_token(Str, Tok):-
    atom_string(Atom, Str),
    (atom_number(Atom, Tok), !; Tok = Atom).

insert_between([X], _ToInsert, [X]):- !.
insert_between([H|T], ToInsert, [H, ToInsert|TInsert]):-
    insert_between(T, ToInsert, TInsert).

split_and_reinsert_character(String, Char, [String]):- split_string(String, Char, "", [String]), !.
split_and_reinsert_character(String, Char, [Prefix, Char]):- string_concat(Prefix, Char, String), !.
split_and_reinsert_character(String, Char, [Char, Prefix]):- string_concat(Char, Prefix, String), !.
split_and_reinsert_character(String, SplitChar, Result):-
    split_string(String, SplitChar, "", Split),
    insert_between(Split, SplitChar, Result).

extract_periods(String, Results):- split_and_reinsert_character(String, ".", Results).
extract_nl(String, Results):- split_and_reinsert_character(String, "\n", Results).

% Numbers
is_quantity(1,singular):- !.
is_quantity(N,plural):- number(N), N \= 1.

% ---------------------------------------------------------------------
% Scratch

% parse_card(Str, Tokens):-
% string_to_tokens(Str, Tokens),
% card(Tokens, []), !.

%string_extract_specials(Result, Head, []).
%string_extract_specials(Result, Head, Rest):-
