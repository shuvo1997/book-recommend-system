%% Knowledge Base
%Story
book('The Little Prince','Antoine de Saint-Exupry',ChildStory,Foreign).
book('Harry Potter and the Sorcerer\'s Stone',ChildStory,Foreign).
book('Alice\'s Adventures in Wonderland','Lewis Carroll',ChildStory,Foreign).
book('The Lion, the Witch and the Wardrobe',' C. S. Lewis',ChildStory,Foreign).
book('The Adventures of Pinocchio','Carlo Collodi',ChildStory,Foreign).

%novels

book('Deyal','Humayun Ahmed', Novel, Bengali).
book('Megheder din','Sadat Hossain',Novel,Bengali).
book('Misir Ali Somogro', 'Humayun Ahmed', 'Thriller',Bengali).
book('Kishore Golpo Somogro', 'Robindra Nath Tagore', ChildStory, Bengali).

book('To Kill a Mockingbird','Harper Lee',Novel,Foreign).
book('Lolita','Vladimir Nabokov',Novel,Foreign).
book('The Lord of the Rings','J.R.R. Tolkien',Novel,Foreign).
book('The Brothers Karamazov','Fyodor Dostoevsky',Novel,Foreign).

book('The Great Gatsby',' F. Scott Fitzgerald','Tragedy',Foreign).

book('Grown Ups','Marian Keyes',Comedy,Foreign).
book('A Very Punchable Face: A Memoir','Colin Jost',Comedy,Foreign).
book('Slouchers: The Novelization','Mike Sacks',Comedy,Foreign).

book('Little Miss Little Compton: A Memoir','Arden Myrin','Biography',Foreign).


%%Rules

foreign_book(X,Y) :- book(X,_,_,Y) , Y == Foreign.
bengali_book(X,Y) :- book(X,_,_Y) , Y \== Foreign.

written_by(X,Y) :- book(X,Y,_,_).

genre(X,Y) :- book(X,_,Y,_).

% X = book Y = writer Z = genres K = Language A = age

suggest_book(X,Y,Z,K) :- book(X,Y,_,K).

recommendation(X,Y,O) :- X =< 18 , Y == 'sad' , O = 'ChildStory, Comedy, Biography'. 
recommendation(X,Y,O) :- X =< 18 , Y == 'happy' , O = 'ChildStory, Novel, Thriller'.
recommendation(X,Y,O) :- X =< 18 , Y == 'normal' , O = 'ChildStory, Comedy, Novel'.
recommendation(X,Y,O) :- X > 18 , Y == 'sad' , O = 'Romance, Comedy, Thriller'.
recommendation(X,Y,O) :- X > 18 , Y == 'happy' , O = 'Biography,Story,Novel'.
recommendation(X,Y,O) :- X > 18 , Y == 'normal' , O = 'Romance,Tragedy,Travelling'.

%% Expert System
start:-
	write('Expert System - Book Recommender'),nl,
	write('What is your name?'),nl,
	read(Name),nl,
	write('Hello '),
	write(Name),nl,
	write('Do you like us to recommend genres or recommend book?'),nl,
	write('write genres/book'),nl,
	read(Dec),nl,
	(Dec == 'genres' -> write('What is your age?'),nl,
						read(Age),nl,
						write('What is your mood?'),nl,
						write('1.sad'),nl,
						write('2.happy'),nl,
						write('3.normal'),nl,
						read(Mood),nl,
						recommendation(Age,Mood,Genre),
						write('You can read books in the following genres: '),
						write(Genre) 
						
						; 
						write('What do you like to read?(Foreign/Bengali book)'),nl,
						write('1.Foreign'),nl,
						write('2.Bengali'),nl,
						read(Language),nl,
						write('Do you have any favourite writer?'),nl,
						write('1.yes'),nl,
						write('2.no'),nl,
						read(Favourite),nl,
						write(Favourite),nl,
						(Favourite == 'yes' -> write('Write the name of your writer:(In CamelCase format)'),nl,
											read(Writer),nl,
											(written_by(X,Writer) -> suggest_book(X,Writer,_,Language),
												write('You should read this book written by him'),
												write(X)
											 ; write('Writer is not present in our knowledge base.'))

											; write('Write the name of your favourite genre:'),nl,
											read(Genre),nl,
											(genre(X,Genre) -> suggest_book(X,Y,Genre,Language),
															write('You can read this book '),
															write(X),write(' '),
															write('by'),write(' '),
															write(Y)
															; write('This genre is not in our KB')
												)
							)
	).
	



