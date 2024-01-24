import urllib.request
import re 
import threading 
from queue import Queue

def crawl(start_page, distance, action): 
    # inicjalizacja zmiennych
    adres = '([a-zA-Z]+.)*[a-zA-Z]+' 
    automat = re.compile('https?://' + adres) # zezwala zarowno na adresy http jak i https
    visited = {} # slownik postaci {url_strony: action(url_strony)}
    crawl_queue = Queue() # kolejka URL do odwiedzenia 
    crawl_queue.put((start_page, 0)) # dodaj strone startowa wraz z glebokoscia 0 do kolejki 
    lock = threading.Lock() # blokada synchronizacji dostępu do udostępnionych danych

    # znajduje wszystkie linki na stronie
    def find_links(text):
        return [ url.group() for url in automat.finditer(text) ]

    # przeglada pojedyncza strone i dodaje jej linki do kolejki
    def crawl_page():
        while not crawl_queue.empty():
            current_page, depth = crawl_queue.get() # wyciagnij strone i jej glebokosc z kolejki
            if depth >= distance:
                crawl_queue.task_done() 
                continue
            text = "" # zawartosc strony
            try:
                with urllib.request.urlopen(current_page) as f:
                    text = f.read().decode('utf-8')
            except: # z jakiegos powodu nie mozna otworzyc strony
                crawl_queue.task_done() 
                continue
            with lock:
                if current_page not in visited: # kazda strone chcemy odwiedzic tylko raz
                    visited[current_page] = action(text) # dodaj strone do odwiedzonych wraz z wynikiem action
                    pages = find_links(text) # znajdz linki do innych stron
                    for url in pages:
                        crawl_queue.put((url, depth+1)) # dodaj link strony i jej glebokosc do kolejki
            crawl_queue.task_done() 

    # stworz liste watkow
    threads: list[threading.Thread] = []
    # stworz i uruchom 20 watkow
    for _ in range(20):
        t = threading.Thread(target=crawl_page)
        t.start()
        threads.append(t)
    crawl_queue.join()
    for t in threads:
        t.join()
    return visited.items()

for url, wynik in crawl("http://www.ii.uni.wroc.pl", 2, lambda text : "Python" in text):
    print(f"{url}: {wynik}")