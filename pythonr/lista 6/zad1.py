import urllib.request, re

def crawl(start_page, distance, action):
    # inicjalizacja zmiennych
    adres = '([a-zA-Z]+.)*[a-zA-Z]+'
    automat = re.compile('https?://' + adres) # zezwala zarowno na adresy http jak i https
    visited = {} # slownik postaci {url_strony: action(url_strony)}

    # znajduje wszystkie linki na stronie
    def find_links(text):
        return [ url.group() for url in automat.finditer(text) ]
    
    def crawl_helper(current_page, depth, distance, action):
        if depth >= distance:
            return
        text = "" # zawartosc strony
        try:
            with urllib.request.urlopen(current_page) as f:
                text = f.read().decode('utf-8')
        except: # z jakiegos powodu nie mozna otworzyc strony
            return
        visited[current_page] = action(text) # dodaj strone do odwiedzonych wraz z wynikiem action
        
        pages = find_links(text) # znajdz linki do innych stron
        for url in pages:
            if url not in visited: # kazda strone chcemy odwiedzic tylko raz
                crawl_helper(url, depth+1, distance, action)
    
    # wywolanie funkcji pomocniczej dla strony startowej
    crawl_helper(start_page, 0, distance, action)
    return visited.items()

import time
start = time.time()
for url, wynik in crawl("http://www.ii.uni.wroc.pl", 2, lambda text : "Python" in text):
    print(f"{url}: {wynik}")
print("Czas: " + str(time.time()-start))