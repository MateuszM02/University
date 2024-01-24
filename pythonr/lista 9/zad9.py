import asyncio
import aiohttp
import csv
import matplotlib.pyplot as plt
import json

# wersja 1 - GUS --------------------------------------------------------------------------------------------

def csv_to_dict(table: str) -> dict:
    # sa rozne rodzaje pomiaru inflacji - ja biore porownanie wzgledem tego samego miesiaca rok temu
    filterData = "Analogiczny miesi\u0105c poprzedniego roku = 100"

    rows = table.split("\n")
    reader = csv.reader(rows, delimiter=";")
    next(reader) # naglowek tabeli - rok, miesiac, wartosc
    inflationDict = {} # slownik (miesiac, rok) = inflacja
    for row in reader:
        if row == [] or row[2] != filterData: # inny sposob pomiaru inflacji
            continue
        # dane sa posortowane od najnowszych, zatem mozna zignorowac reszte, bo to starsze lata
        elif row[3] not in ['2021', '2022']:
            if row[3] == '2023': # nie uwzgledniaj niepelnego roku
                continue
            break
        inflationRate = float(row[5].replace(',', '.')) - 100 # zamiana postaci '109,5' -> 9.5
        inflationDict[(int(row[4]), int(row[3]))] = inflationRate # (miesiac, rok) = inflacja
    return inflationDict

async def get_data_gus():
        url = "https://stat.gov.pl/download/gfx/portalinformacyjny/pl/defaultstronaopisowa/4741/1/1/miesieczne_wskazniki_cen_towarow_i_uslug_konsumpcyjnych_od_1982_roku_15-11-2023.csv"

        # tworzymy sesje aby pobrac dane z pliku csv
        async with aiohttp.ClientSession() as session:
            # pobierz dane ze strony
            async with session.get(url) as response:
                tableCSV = await response.text(encoding='windows-1250')
                return csv_to_dict(tableCSV)

# wersja 2 - NBP (cena zlota) -------------------------------------------------------------------------------

def prices_to_inflation(prices: dict) -> dict:
    inflationDict = {}
    for month, year in prices:
        if year < 2021:
            continue
        oldPrice = prices[(month, year - 1)]
        inflationDict[(month, year)] = (prices[(month, year)] - oldPrice) / oldPrice * 100
    return inflationDict

def format_url(baseUrl: str, rok, miesiac, dzien) -> str:
    d0 = ""
    m0 = ""
    if dzien < 10:
        d0 = "0"
    if miesiac < 10:
        m0 = "0"
    return str.format(f"{baseUrl}/{rok}-{m0}{miesiac}-{d0}{dzien}")

async def get_data_nbp():
        baseUrl = "http://api.nbp.pl/api/cenyzlota"
        pricesDict = {} # slownik (miesiac, rok) = cena

        # tworzymy sesje aby pobrac dane w postaci JSON
        async with aiohttp.ClientSession() as session:
            for rok in [2020, 2021, 2022]:
                for miesiac in range(1, 13):
                    # nie kazdego dnia gielda jest czynna, dlatego robimy petle w poszukiwaniu pierwszego czynnego dnia danego miesiaca
                    for dzien in range(1, 32):
                        fullUrl = format_url(baseUrl, rok, miesiac, dzien)
                        # pobierz dane ze strony za pomoca kwerendy
                        async with session.get(fullUrl) as response:
                            if response.status == 200: # gielda byla otwarta tego dnia, zwroc cene
                                priceJSON = await response.text(encoding='windows-1250')
                                priceJSON = json.loads(priceJSON)[0]
                                pricesDict[(miesiac, rok)] = priceJSON["cena"]
                                break
        return prices_to_inflation(pricesDict)

# wersja 3 - przewidywania na 2023 --------------------------------------------------------------------------

# inflacja bedzie liniowo rosnac/malec w zaleznosci od trendu
# trend to srednia wazona roznic w zmianach inflacji miedzy miesiacami
# trend zalezy najmnocniej od inflacji w niedawnych miesiacach, mniej od tych dawniejszych

async def predict2023(gusDict: dict) -> dict:
    smallerMonth = gusDict[(11, 2022)]
    biggerMonth = gusDict[(12, 2022)]
    _trend = 0 # o tyle prognozujemy wzrost inflacji miesiac do miesiaca w 2023
    sumaWag = 78

    for month in range(12, 0, -1):
        _trend += (biggerMonth - smallerMonth) * month
        if month > 2:
            smallerMonth, biggerMonth = gusDict[(month - 2, 2022)], smallerMonth
        else:
            smallerMonth, biggerMonth = gusDict[(month + 10, 2021)], smallerMonth
    _trend /= sumaWag

    preDict = {}
    biggerMonth = gusDict[(12, 2022)]
    for month in range(1, 13):
        preDict[(month, 2023)] = biggerMonth + month * _trend
    return preDict

# tworzenie wykresu -----------------------------------------------------------------------------------------

async def show_plot(gusDict: dict, nbpDict: dict, preDict: dict):
    months = [i for i in range(1, 13)]
    gusInflation = [] # nieposortowane miesiace !
    nbpInflation = list(nbpDict.values())
    preDictInflation = list(preDict.values())

    for pair in nbpDict:
        gusInflation.append(gusDict[pair])

    plt.xticks(months)
    plt.title("Inflacja w 2021 i 2022")
    plt.xlabel("numer miesiąca")
    plt.ylabel("wysokosc inflacji w %")

    plt.plot(months, gusInflation[:12]) # gus 2021
    plt.plot(months, gusInflation[12:]) # gus 2022
    plt.plot(months, nbpInflation[:12]) # nbp 2021
    plt.plot(months, nbpInflation[12:]) # nbp 2022
    plt.plot(months, preDictInflation) # przewidywania na 2023 na podstawie gus 2022

    plt.legend(["GUS 2021", "GUS 2022", "NBP 2021", "NBP 2022", "przewidywania 2023"])
    plt.savefig("inflacja.png")
    plt.show()

# tworzy i uruchamia zadania asynchroniczne
async def main():
    gusDict, nbpDict = await asyncio.gather(get_data_gus(), get_data_nbp())
    preDict, = await asyncio.gather(predict2023(gusDict))
    await asyncio.gather(show_plot(gusDict, nbpDict, preDict))

asyncio.run(main())
