# AstonMovieList + MVP
Test task for aston -> Приложение кинолента

![приветствиеКит](https://github.com/AlexShtandaruk/astonMovieList/assets/125973696/dbfc4ecc-79f6-438b-a9db-8a4599dc9cf7)
![работаКит](https://github.com/AlexShtandaruk/astonMovieList/assets/125973696/706deb78-22fa-4f15-b8b7-37808d8f21ac)

# Использованный стек
UIKit, URLSession, Router + Launcher, AssemblyBuilder, UserDefaults, GCD, CoreAnimation

так же,

- Локализация:
    *english и русский.
- Анимация вынесена в отдельный модуль CoreAnimation:
    *Сделано для того, чтобы показать, что знаю как использовать остальные модификаторы доступа, создавать пакеты. Ну и по сути, анимация занимает невозможное количество места, поэтому думаю ее обычно и выделяют в отдельный модуль.
- Созданы кастомные класс со стандартными методами, сервисами и т.д. (DRY)
- Кастомные шрифты;
- Кастомные цвета.

# Описание

* При запуске приложения происходит загрузка данных с RestAPI или же, в случае отсутствия интернет-подключения, с диска пользователя сохраненных при прошлой загрузке данных.
* Стартовый экран, если пользователь еще не авторизовался - экран авторизации, в другом случае пользователь сразу попадает на экран со списком фильмов.

*flow авторизации
    - логин: hudihka, password: 123;
    - при неверном ввод в тестовое поле появляется уведомление с типом ошибки;
    - кнопки анимированы;
    - кнопки sign in и forgot password для наполения, без реализованного функционала.

*flow списка фильмов
    - оба экрана сделаны таблицами для удобства;
    - сортировка на первом листе сделана по годам выхода фильмов в прокат;
    - добавлен фильтр по жанрам, которые захардкодил;
    - экран Detail дополнен кнопкой к началу просмотра и коллекцией снизу, просто для визуального дополнения (не придумал, что можно тянуть в коллекцию, поэтому просто схемотично обозначил)
