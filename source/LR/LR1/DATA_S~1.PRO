% Заполнитель базы данных симптомов.

DOMAINS
	years_count = float

	gender_name = string

	object          = string
	characteristics = string 
	value           = string

	area = string

DATABASE
	% См. SRC.PRO

	param(object, characteristics, value)

	pain(characteristics, area)
	redness(area)
	edema(area)
	excreta(area, characteristics)
	fracture(area)
	lacrimation

	temperature(area, characteristics) 
	conjunctivitis
	phlegmon
	weakness
	leukocytosis

GOAL
	clearwindow, save("D:\lr1_symptoms.db").

CLAUSES
	param("череп", "форма", "круглая").
	param("нос", "ширина", "узкая").
	param("раса", "принадлежность", "европеоидная").
	param("раса", "принадлежность", "монголоидная").
	param("раса", "принадлежность", "американоидная").
	param("раса", "принадлежность", "автрало-веддоидная").

	pain("внезапная", "нос").
	pain("внезапная", "зубы").

	redness("слезный канал").

	edema("слезный канал").

	excreta("слезные точки", "гной").

	fracture("слезный мешок").

	lacrimation.

	temperature("тела", "поднимается").

	conjunctivitis.
	phlegmon.
	weakness.
	leukocytosis.
