:- module(arkham_main,
    [sentence/3,
    chaos_token/3]).
:- use_module('parse').
:- load_test_files([]).

% events first
% action + card in hand = effects
% Lots of checks skipped here AOO, e.g.
% 1 fewer action, card in discard pile, results of playing the card
%
% "Heal 1 damage"
%   ("2, instead"? it's a number, so replace the most recent one)
% "Gain 3 resources."

card_text(card(Qualifiers, _Effects)) -->
    qualifiers(Qualifiers), newline, card_body.
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

pool_verb(take,decrease,health_pool).
pool_verb(take,decrease,sanity_pool).

pool_verb(heal,increase,health_pool).
pool_verb(heal,increase,sanity_pool).

pool_verb(gain,increase,resource_pool).
pool_verb(lose,decrease,resource_pool).

pool_verb(gain,increase,clue_pool).
pool_verb(lose,decrease,clue_pool).

token_pool(damage,_,health_pool).
token_pool(horror,_,sanity_pool).
token_pool(clue,singular,clue_pool).
token_pool(clues,plural,clue_pool).
token_pool(resource,singular,resource_pool).
token_pool(resources,plural,resource_pool).

% Chaos Tokens
chaos_token(skull) --> ['[skull]'].
chaos_token(cultist) --> ['[cultist]'].
chaos_token(elder_thing) --> ['[elder_thing]'].
chaos_token(tablet) --> ['[tablet]'].
chaos_token(auto_fail) --> ['[auto_fail]'].
chaos_token(elder_sign) --> ['[elder_sign]'].
