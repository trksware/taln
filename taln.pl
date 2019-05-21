% Auteur:
% Date: 2017-12-13



% prédicat interpreter/2
interpreter(LISTE, SENS ) :-  analyse1(SENS, LISTE, [] ).
interpreter(LISTE, SENS ) :-  analyse2(SENS, LISTE, [] ).

analyse1(SEM) --> gv(ACT), gn(AGNT), { SEM =.. [ACT, AGNT]}.
gv(ACT) --> pronom , v(ACT).
gn(AGNT) --> art, nc(_), adj(AGNT).
gn(AGNT) --> art, nc(AGNT).

analyse2(SEM) --> gn2(ACT), gv2(AGNT), { SEM =.. [ACT, AGNT]}.
gn2(ACT) --> pronom, nc(ACT).
gv2(AGNT) --> v(_),art, nc(AGNT).

%prédicat repondre/2
repondre(SENS, X):- SENS =.. [ACT, AGNT] , SEM =.. [ACT, AGNT, X], fait(SEM).

repondre(SENS, X):- SENS =.. [ACT, AGNT] , SEM =.. [ACT, X, AGNT], fait(SEM).



pronom --> [qui].
pronom --> [que].
pronom --> [quel].

art --> [le].
art --> [la].
art --> [un].
art --> [l].
art --> [du].

adj( rouge ) --> [rouge].
adj( verte ) --> [verte].
adj( blanche ) --> [blanche].
adj( jaune ) --> [jaune].

nc( anglais ) --> [anglais].
nc( espagnol ) --> [espagnol].
nc( chien ) --> [chien].
nc( cafe ) --> [cafe].
nc( the ) --> [the].
nc( ukrainien ) --> [ukrainien].
nc( sculpteur ) --> [sculpteur].
nc( escargots ) --> [escargots].
nc( diplomate ) --> [diplomate].
nc( jus_orange ) --> [jus_orange].
nc( violoniste ) --> [violoniste].
nc( japonais ) --> [japonais].
nc( acrobate ) --> [acrobate].
nc( maison ) --> [maison].
nc( animal ) --> [animal].

v( habite ) --> [habite].
v( boit ) --> [boit].
v( a ) --> [a].

%Qui habite la maison rouge ?
%habite(rouge).
%Qui habite la maison jaune ?
%habite(jaune).
%que boit l'ukrainien ?
%boit(ukrainien).
%que boit le violoniste ?
%boit(violoniste).
%Quel animal a l'espagnole ?
%animal(espagnole).



% l'anglais habite la maison rouge :
fait(habite(rouge, anglais)).
% l'espagnol a un chien
fait(animal(espagnol, chien)).
% dans la maison verte on boit du café :
fait(boit(verte, cafe)).
% l'ukrainien boit du thé :
fait(boit(the, ukrainien)).
% la maison verte est immédiatement à droite de la maison blanche :
fait(est_a_droite_de(verte, blanche)).
% le sculpteur élève des escargots :
fait(occupation(sculpteur, escargots)).
% le diplomate habite la maison jaune :
fait(habite(jaune, diplomate)).
% le violoniste boit du jus d'orange :
fait(boit(jus_orange, violoniste)).
% le japonais est acrobate :
fait(occupation(japonais, acrobate)).




% Le prédicat lire/2 lit une chaîne de caractères Chaine entre apostrophes
% et terminée par un point.
% Resultat correspond à la liste des mots contenus dans la phrase.
% Les signes de ponctuation ne sont pas gérés.
lire(Chaine,Resultat):- write('Entrer la phrase '), read(Chaine),
                        name(Chaine, Temp), chaine_liste(Temp, Resultat),!.
% Prédicat de transformation de chaîne en liste
chaine_liste([],[]).
chaine_liste(Liste,[Mot|Reste]):- separer(Liste,32,A,B), name(Mot,A),
chaine_liste(B,Reste).
% Sépare une liste par rapport à un élément
separer([],X,[],[]):-!.
separer([X|R],X,[],R):-!.
separer([A|R],X,[A|Av],Ap):- X\==A, !, separer(R,X,Av,Ap).


lancer :- lire(Chaine, Resultat), interpreter(Resultat, S), repondre(S, R), write(R).