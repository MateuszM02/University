import asyncio
import aiohttp
import json
from prywatne import api_key # plik z kluczem API do Quotes

def write_file(filename, data):
    with open(filename, "w") as f:
        f.write(data)

# do pobierania cytatow z Quotes API
async def get_random_quote(headers):
    url = f"https://quotes15.p.rapidapi.com/quotes/random/"

    async with aiohttp.ClientSession() as session:
        async with session.get(url, headers=headers) as response:
            try:
                response.raise_for_status() # sprawdz, czy kod odpowiedzi jest poprawny
                data = await response.text() # pobieramy cala odpowiedz
                data_as_json = json.loads(data) # konwertujemy ja do jsona
                write_file(f"full_quote_answer.txt", data) # wypisujemy cala zawartosc odpowiedzi
                write_file(f"quote.txt", data_as_json['content']) # wypisujemy sam cytat
                print(f"Losowy cytat zostal zapisany")
            except aiohttp.ClientResponseError as e: # zlap i rzuc blad odpowiedzi
                raise e

# do pobierania danych o kotach z The Cat API
async def get_cat_data():
    url = "https://api.thecatapi.com/v1/images/search?format=json"
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            data = await response.text()
            write_file("cat_data.txt", data)
            print("Zapisano dane z The Cat API")

# tworzy i uruchamia zadania asynchroniczne
async def main():
    tasks = []
    headers = {
    "x-rapidapi-key": api_key,
    "x-rapidapi-host": "quotes15.p.rapidapi.com"
    }
    tasks.append(get_random_quote(headers))
    tasks.append(get_cat_data())
    await asyncio.gather(*tasks)

asyncio.run(main())