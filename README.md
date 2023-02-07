# SQL-project using Microsoft SQL Server

Temat: Baza obsługująca wybrane aspekty funkcjonalne żłobka. 

Baza wspiera działalność żłobka. Zawiera rejestr dzieci uczęszczających do żłobka, rodziców tych dzieci oraz opiekunek. Prowadzi rejestr zaległych płatności, wypożyczeń zabawek oraz uwag i aktywności dzieci.

--------------------------------------------------------------------------------------------------------------------------------------------------------------

Raport zawiera następujące widoki:

•	Widok zawierający komplet informacji o wszystkich dzieciach w żłobku w układzie alfabetycznym

•	Widok zawierające komplet informacji o rodzicach dzieci w żłobku w układzie alfabetycznym

•	Zestawienie wyświetlające dzieci z niestandardową dietą

•	Widok przedstawiający grupy w żłobku, przydzielone opiekunki i nr sali, w których mają zajęcia.

•	Widok zawierający dane opiekunek w układzie alfabetycznym

•	Dla każdego dziecka przydzielona jest szafka

•	Istnieje możliwość zapisania dziecka do żłobka

•	Rodzice mogą mieć więcej niż jedno dziecko w żłobku

•	Każde dziecko należy do jednej z grup

•	Widok pokazujący pozytywne i negatywne uwagi dzieci 

•	Widok pokazujący, kto z rodziców ma płatności do uregulowania

•	Widok pokazujące zabawki dostępne w żłobku wraz z ich wypożyczeniami

•	Zestawienie dzieci, które nigdy nie wypożyczały zabawek

•	Funkcja zezwalająca na wypożyczenie maksymalnie dwóch zabawek

•	Cennik poszczególnych kosztów

•	Obliczenie daty oddania zabawki, jeśli ktoś jeszcze nie oddał. Dziecko ma 30 dni na oddanie wypożyczonej zabawki.

•	Widoki grup wraz dziećmi, które do nich przynależą

•	Funkcja sprawdzająca, w której sali ma zajęcia dana grupa


Przykładowy constraint: 
Można dodać dziecko, które ma co najmniej 5 miesięcy i maksymalnie 36 miesięcy.

alter table Dane_Dziecka
add constraint CW_Wiek
check (Ilość_miesięcy>=5 and Ilość_miesięcy<=36)

