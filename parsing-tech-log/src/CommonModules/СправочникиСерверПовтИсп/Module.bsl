
Функция ПолучитьСобытие(Знач ИмяСобытия) Экспорт
	Возврат ПолучитьСсылкуСправочникаПоНаименованию("События", ИмяСобытия, Истина);
КонецФункции

Функция ПолучитьПроцесс(Знач Процесс) Экспорт
	Процесс = НРег(Процесс);
	Возврат ПолучитьСсылкуСправочникаПоНаименованию("Процессы", Процесс, Истина);
КонецФункции

Функция ПолучитьСвойство(Знач ИмяСвойства) Экспорт
	Если СтрДлина(ИмяСвойства)>100 Тогда
		ИмяСвойства = Прав(ИмяСвойства,СтрДлина(ИмяСвойства)-100);
	КонецЕсли;
	Возврат ПолучитьСсылкуСправочникаПоНаименованию("Свойства", ИмяСвойства, Истина);
КонецФункции

//общая функция для простых справочников
Функция ПолучитьСсылкуСправочникаПоНаименованию(ЗНАЧ ИмяСправочника, ЗНАЧ Наименование, СоздатьЕслиНеНайден = Ложь)
	Результат = Неопределено;		
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	|	Т.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник."+ИмяСправочника+" КАК Т
	|ГДЕ
	|	НЕ Т.ПометкаУдаления
	|	И Т.Наименование = &Наименование");
	Запрос.УстановитьПараметр("Наименование", Наименование);
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Если СоздатьЕслиНеНайден Тогда
			СправочникОбъект = Справочники[ИмяСправочника].СоздатьЭлемент();
			СправочникОбъект.Наименование = Наименование;
			СправочникОбъект.Записать();
			Результат = СправочникОбъект.Ссылка;
		Иначе
			Результат = Справочники[ИмяСправочника].ПустаяСсылка();
		КонецЕсли;
	Иначе
		Результат = РезультатЗапроса.Выгрузить()[0].Ссылка;
	КонецЕсли;
	Возврат Результат;	
КонецФункции

Функция МногострочныеСвойства() Экспорт
	Результат = Новый Соответствие;
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	Свойства.Ссылка
	|ИЗ
	|	Справочник.Свойства КАК Свойства
	|ГДЕ
	|	Свойства.МногострочныйРежим = ИСТИНА");
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Результат.Вставить(Выборка.Ссылка, Истина);
	КонецЦикла;
	Возврат Новый ФиксированноеСоответствие(Результат);
КонецФункции