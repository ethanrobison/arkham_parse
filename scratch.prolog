:- set_prolog_flag(double_quotes,codes).

action_keyword(Action) --> "<b>", action_word(Action), (".";""), "</b>".
action_word(fight) --> "fight",!.
action_word(evade) --> "evade",!.

%foo --> "gain", " ", qty(N), " ", "resources", ".".
digits --> N, {num(N)}.
num(N):- string_to_atom(N,A),atom_number(A,_Qty).

%digit(1)-->"1".
digit(D)-->[D], {char_code(D,digit)}.
verb-->"avoids".

:- begin_tests(upper_and_lower_token).

% n.b., you have to set the flag in here, apparently
:- set_prolog_flag(double_quotes,codes).

test(fight_l):- action_word(fight, "fight", []).
test(evade_u):- action_word(evade, "evade", []).

:- end_tests(upper_and_lower_token).

card_text(card(Qualifiers, _Effects)) --> qualifiers(Qualifiers), newline, card_body.
card_text --> card_body.

card_body --> paragraph, newline, card_body.
card_body --> paragraph. % , eoc. % TODO?
paragraph --> sentence(_), period, paragraph.
paragraph --> sentence(_).

period --> ['.'].
newline --> ['\n'].

qualifiers([QH|QT]) --> [Q], {is_qualifier(Q,QH)}, qualifiers(QT).
qualifiers([Qual]) --> [Q], {is_qualifier(Q, Qual)}.
is_qualifier(exceptional,exceptional).
is_qualifier(permanent,permanent).
% Limit 1 per deck.
% Limit 1 per investigator.
% Limit 1 footwear per investigator.
% TODO need some kind of a qualifier phrase?
is_qualifier(limit,limit(N,A)) -->
    [limit],
    [N],{is_quantity(N,_Nos)},
    [per],[A], {is_area(A)}.
%is_qualifier(limit, limit(1,deck,[footwear])).

is_area(deck).
is_area(investigator).

sentence(effect(Dir,N,Pool)) -->
    [B], {pool_verb(B,Dir,Pool)},
    [N], {is_quantity(N,Nos)},
    [Token], {token_pool(Token,Nos,Pool)},
    !.
