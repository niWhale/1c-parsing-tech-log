Процедура ЗаписатьСобытие(СтруктураЗаписи) Экспорт
	СобытиеОбъект = Справочники.СобытияЗамера.СоздатьЭлемент();
	//реквизиты
	ЗаполнитьЗначенияСвойств(СобытиеОбъект, СтруктураЗаписи, "Владелец, Файл, НомерСтрокиФайла, ДатаСобытия, ДатаСобытияМкс, ДлительностьМкс, ТипСобытия, УровеньСобытия, ВсеСвойства");
	//тч
	Для Каждого элемент из СтруктураЗаписи.КлючевыеСвойства Цикл
		строкасвойства = СобытиеОбъект.КлючевыеСвойства.Добавить();
		строкасвойства.Свойство = элемент.Ключ;
		строкасвойства.Значение = элемент.Значение;
	КонецЦикла;
	СобытиеОбъект.Записать();
КонецПроцедуры