% Вариант 17.
% Реализовать на языке Prolog программу для диагностики заболевания "Дакриоцистит".

DOMAINS
	years_count = real

	gender_name = string

	object          = string
	characteristics = string 
	value           = string

	area = string

CONSTANTS
	% Путь к файлу с симптомами болезни.
	diseasepath = "D:\\LR1_SYMP.DB"
	% Путь к директории с файлами пациентов.
	patientprefix  = "D:\\"

% База данных симптомов заболевания.
DATABASE - symptoms_db
	% Антропометрический параметр больного.
	% object          - участок тела / параметр (пример - нос).
	% characteristics - характеристика (например, форма, длина, ширина).
	% value           - значение (большой, маленький, узкий).
	param(object, characteristics, value)

	% Боль.
	% characteristics - характер боли (острая, ноющая).
	% area            - участок тела, подверженный боли.
	pain(characteristics, area)
	% Покраснение.
	% area - покрасневший участок тела.
	redness(area)
	% Отек.
	% area - отекший участок тела.
	edema(area)
	% Выделения.
	% area            - место, из которого выделяется секрет.
	% characteristics - характер выделений (гной, слезы).
	excreta(area, characteristics)
	% Разрав, вскрытие
	% area - участок тела, подверженный разрыву (слезный мешок).
	fracture(area)
	% Слезотечение.
	lacrimation

	% Температура.
	% area            - область.
	% characteristics - характер изменения (поднимается).
	temperature(area, characteristics) 
	% Конъюнктивит.
	conjunctivitis
	% Флегмона.
	phlegmon
	% Слабость.
	weakness
	% Лейкоцитоз в анализе крови.
	leukocytosis

% База данных симптомов пациента.
DATABASE - patient_db
	% Предикаты, входящие в этот блок, в точности повторяют
	% предикаты БД симптомов по смыслу и параметра.
	% Для разделения предикатов те предикаты, которые
	% описывают состояние пациента, имеют префикс p.
	ppain(characteristics, area)
	predness(area)
	pedema(area)
	pexcreta(area, characteristics)
	pfracture(area)
	placrimation
	pparam(object, characteristics, value)
	ptemperature(area, characteristics)
	pconjunctivitis
	pphlegmon
	pweakness
	pleukocytosis

	% Возраст пациента
	age(years_count)
	% Пол пациента - "M" или "F".
	gender(gender_name)

PREDICATES
	start

	% Загружает все необходимые ресурсы.
	init_resources

	% Загружает симптомы болезни.
	load_disease_db
	% Открывает диалог выбора файла пациента.
	choose_patient_file(string)
	% Загружает симптомы пациента из выбранного файла.
	load_patient_db(string)

	% Осуществляет диагностику на подготовленных данных.
	diagnose

	% Проверяет наличие симптомов.
	symptoms
	% Проверяет соответствие общего сотояния пациента состоянию больного.
	general
	% Проверяет антропометрические параметры (входит в general).
	params
	% Проверяет сопуствующие болезни факторы.
	additional

GOAL
	clearwindow, start.

CLAUSES
	start :- init_resources, diagnose.

	init_resources :- load_disease_db, choose_patient_file(PF), load_patient_db(PF).

	load_disease_db :- existfile(diseasepath),
			   consult(diseasepath, symptoms_db).

	choose_patient_file(PatientFile) :- makewindow(1, 27, 57, "", 0, 0, 25, 80),
                                            dir(patientprefix, "*.*", PatientFile),
                                            removewindow; removewindow, fail.

	load_patient_db(PatientFile) :- existfile(PatientFile),
                                        consult(PatientFile, patient_db).

	diagnose :- symptoms, general, additional, write("ILL"), nl.
	diagnose :- write("HEALTHY"), nl.

	symptoms :- ppain(PainCharacter, PainArea), pain(PainCharacter, PainArea),
		    predness(RednessArea), redness(RednessArea),
		    pedema(EdemaArea), edema(EdemaArea),
		    pexcreta(ExcretaArea, ExcretaCharacter), excreta(ExcretaArea, ExcretaCharacter),
	            pfracture(FractureArea), fracture(FractureArea),
		    placrimation.

	general :- age(Y), Y < 1.0, params.
	general :- age(Y), Y >= 40.0, gender(Gender), Gender = "F", params.

	params :- pparam(Object, Characteristics, Value), param(Object, Characteristics, Value), fail.
	params.
	
	additional :- ptemperature(TempArea, TempCharacteristics), temperature(TempArea, TempCharacteristics),
		      pconjunctivitis;
		      pphlegmon;
		      pweakness;
		      pleukocytosis.
