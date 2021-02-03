

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	СписокПриАктивизацииСтрокиНаСервере(Элементы.Список.ТекущиеДанные.Номер);
КонецПроцедуры

&НаСервере
Процедура СписокПриАктивизацииСтрокиНаСервере(ОснованиеНомер)
	
	Основание = Документы.ЗаказыПоставщикам.НайтиПоНомеру(ОснованиеНомер);
	
	ТаблицаПодчиненности.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ПриходныеНакладные.Ссылка КАК Приходная
		|ИЗ
		|	Документ.ПриходныеНакладные КАК ПриходныеНакладные
		|ГДЕ
		|	ПриходныеНакладные.Основание = &Основание";
	
	Запрос.УстановитьПараметр("Основание", Основание.Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НовСтр = ТаблицаПодчиненности.Добавить();
		НовСтр.Документ = ВыборкаДетальныеЗаписи.Приходная;
	КонецЦикла;

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	РасходыДенежныхСредств.Ссылка
		|ИЗ
		|	Документ.РасходыДенежныхСредств КАК РасходыДенежныхСредств
		|ГДЕ
		|	РасходыДенежныхСредств.Основание = &Основание";
	
	Запрос.УстановитьПараметр("Основание", Основание);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НовСтр = ТаблицаПодчиненности.Добавить();
		НовСтр.Документ = ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;


КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПодчиненностиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	//ОткрытьЗначение(Элементы.ТаблицаПодчиненности.ТекущиеДанные.Документ);
КонецПроцедуры

