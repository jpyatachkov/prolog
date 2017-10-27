% Вариант 17
% Дана база данных вопросов и ответов. Написать программу, которая выводит
% вопросы на экран в заранее заданном порядке, фиксирует ответы пользователя и
% проверяет их правильность.

CONSTANTS
	dbfile = "D:\\LR2_QA.DB"

DOMAINS
	question = string
	answer   = string

DATABASE
	item(question, answer)

PREDICATES
	start

	show_window
	make_polling
	check_answer(string, string)
	
GOAL
	clearwindow, start.

CLAUSES
	start :- show_window, existfile(dbfile), consult(dbfile), make_polling.

	show_window :- makewindow(1, 27, 57, "POLLING", 0, 0, 25, 80).

	make_polling :- item(Q, A), 
                        write(Q), nl, 
                        readln(Given), check_answer(A, Given),
		        fail.

	check_answer(Correct, Given) :- upper_lower(Correct, LCorrect),
	                                upper_lower(Given, LGiven),
	                                LGiven = LCorrect,
	                                write("CORRECT"), nl, !;
	                                write("WRONG"), nl.
