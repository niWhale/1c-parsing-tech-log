

&НаКлиенте
Процедура СобытиеОткрыть(Команда)
	ПараметрыКонструктора = Новый Массив;
	ПараметрыКонструктора.Добавить(ПолучитьКлючСобытия());
	ЖурналКлючЗаписи = Новый(Тип("РегистрСведенийКлючЗаписи.Журнал"), ПараметрыКонструктора);
	ПараметрыФормы = Новый Структура("Ключ,ТолькоПросмотр", ЖурналКлючЗаписи, Истина);
	ОткрытьФорму("РегистрСведений.Журнал.Форма.ФормаЗаписи", ПараметрыФормы, ЭтаФорма, , , , , РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаСервере
Функция ПолучитьКлючСобытия()
	СтруктураКлюча = Новый Структура("Замер,Процесс,ПроцессID,ПериодФайла,ПериодСобытия,ДоляПериода,Событие,КлючСобытия");
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	|	Журнал.Замер,
	|	Журнал.Процесс,
	|	Журнал.ПроцессID,
	|	Журнал.ПериодФайла,
	|	Журнал.ПериодСобытия,
	|	Журнал.ДоляПериода,
	|	Журнал.Событие,
	|	Журнал.КлючСобытия
	|ИЗ
	|	РегистрСведений.Журнал КАК Журнал
	|ГДЕ
	|	Журнал.Замер = &Замер
	|	И Журнал.Процесс = &Процесс
	|	И Журнал.ПроцессID = &ПроцессID
	|	И Журнал.ПериодФайла = &ПериодФайла
	|	И Журнал.ПериодСобытия = &ПериодСобытия
	|	И Журнал.КлючСобытия = &КлючСобытия";
	Запрос.УстановитьПараметр("Замер", Запись.Замер);
	Запрос.УстановитьПараметр("Процесс", Запись.Процесс);
	Запрос.УстановитьПараметр("ПроцессID", Запись.ПроцессID);
	Запрос.УстановитьПараметр("ПериодФайла", Запись.ПериодФайла);
	Запрос.УстановитьПараметр("ПериодСобытия", Запись.ПериодСобытия);
	Запрос.УстановитьПараметр("КлючСобытия", Запись.КлючСобытия);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	ЗаполнитьЗначенияСвойств(СтруктураКлюча, Выборка);
	
	Возврат СтруктураКлюча;
КонецФункции