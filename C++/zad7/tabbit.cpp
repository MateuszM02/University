#include "tabbit.hpp"

using namespace std;
using namespace obliczenia;

int const tabbit::word_size = 32;

tabbit::tabbit (int s) {
    len = s/32;
    tab = new uint64_t [s];
}

tabbit::tabbit (uint64_t tb) {
    len = 1;
    tab = new uint64_t [1];
    *tab = tb;
}

tabbit::tabbit (const tabbit &tb) {
    len = tb.len;
    tab = new uint64_t [len];
    for (int i = 0; i < len; i++) tab[i] = tb.tab[i];
}

tabbit & tabbit::operator = (const tabbit &tb) {
    if (&tb == this) return *this;

    this->~tabbit();
    this->len = tb.len;
    this->tab = new uint64_t [this->len];

    for (int i = 0; i < this->len; i++) tab[i] = tb.tab[i];

    return *this;
}

tabbit::tabbit (tabbit &&tb) {
    len = tb.len;
    tab = tb.tab;
    tb.len = 0;
    tb.tab = nullptr;
}

tabbit & tabbit::operator = (tabbit &&tb) {
    if (&tb == this) return *this;

    this->~tabbit();
    swap(this->len, tb.len);
    swap(this->tab, tb.tab);

    return *this;
}

tabbit::~tabbit () {
    len = 0;
    delete [] tab;
}

ostream & operator << (ostream &st, const tabbit &tb) {
    int i = tb.size() - 1;
    while (i >= 0) {
        for (int j = 32; j > 0; j--) st << tb[j];
        i--;
    }
    return st;
}

bool tabbit::read (int i) const {
    int where = 0;
    while ((where + 1) * 32 < i) where ++;

    uint64_t pom = (uint64_t)pow(2, i - where * 32);

    return pom & tab[where];
}

void tabbit::write (int i, bool b) {
    int where = 0;
    while ((where + 1) * 32 < i) where ++;

    uint64_t pom = (uint64_t)pow(2, i - (where * 32));

    if (b) tab[where] = tab[where] | pom;
    else   tab[where] = tab[where] & (!pom);
}

bool tabbit::operator [] (int i) const {
    return read (i);
}

uint64_t tabbit::operator [] (int i) {
    int where = 0;
    while ((where + 1) * 32 < i) where++;

    uint64_t pot = pow(2, i - (where * 32));
    tab[where] = tab[where] & (!pot);

    return tab[where] & (!pot);
}

int tabbit::size () const {
    return len;
}

tabbit tabbit::operator | (const tabbit &tb) {
    int new_length;
    if (len >= tb.len) new_length = len;
    else new_length = tb.len;

    uint64_t * pom = new uint64_t[new_length];

    int i = 0;
    while (i < new_length) {
        if (i < len && i < tb.len) pom[i] = tab[i] | tb.tab[i];
        else if (i < len) pom[i] = tab[i];
        else pom[i] = tb.tab[i];
        i++;
    }

    tabbit ret (*pom);
    ret.tab = pom;
    ret.len = new_length;

    return ret;
}

tabbit & tabbit::operator |= (const tabbit &tb) {
    int new_length;
    if (len >= tb.len) new_length = len;
    else new_length = tb.len;

    uint64_t * pom = new uint64_t[new_length];

    int i = 0;
    while (i < new_length) {
        if (i < len && i < tb.len) pom[i] = tab[i] | tb.tab[i];
        else if (i < len) pom[i] = tab[i];
        else pom[i] = tb.tab[i];
        i++;
    }

    delete[] tab;
    pom = tab;
    len = new_length;

    return *this;
}

tabbit tabbit::operator & (const tabbit &tb) {
    int new_length;
    if (len >= tb.len) new_length = len;
    else new_length = tb.len;

    uint64_t * pom = new uint64_t[new_length];

    int i = 0;
    while (i < new_length) {
        if (new_length == len) {
            if (i > tb.len) pom[i] = 0;
            else pom[i] = tab[i] & tb.tab[i-(len-tb.len)];
        }
        else {
            if (i > len) pom[i] = 0;
            else pom[i] = tab[i-(tb.len-len)] & tb.tab[i];
        }
        i++;
    }

    tabbit ret (*pom);
    ret.len = new_length;
    ret.tab = pom;

    return ret;
}

tabbit & tabbit::operator &= (const tabbit &tb) {
    int new_length;
    if (len >= tb.len) new_length = len;
    else new_length = tb.len;

    uint64_t * pom = new uint64_t [new_length];

    int i = 0;
    while (i < new_length) {
        if (new_length == len) {
            if (i > tb.len) pom[i] = 0;
            else pom[i] = tab[i] & tb.tab[i-(len-tb.len)];
        }
        else {
            if (i > len) pom[i] = 0;
            else pom[i] = tab[i-(tb.len-len)] & tb.tab[i];
        }
        i++;
    }

    delete[] tab;
    tab = pom;
    len = new_length;

    return *this;
}

tabbit tabbit::operator ^ (const tabbit &tb) {
    int new_length;
    if (len >= tb.len) new_length = len;
    else new_length = tb.len;

    uint64_t * pom = new uint64_t[new_length];

    int i = 0;
    while (i < new_length) {
        if (new_length == len) {
            if (i > tb.len) pom[i] = tab[i];
            else pom[i] = tab[i] ^ tb.tab[i-(len-tb.len)];
        }
        else {
            if (i > len) pom[i] = tb.tab[i];
            else pom[i] = tab[i-(tb.len-len)] ^ tb.tab[i];
        }
        i++;
    }

    tabbit ret (*pom);
    ret.len = new_length;
    ret.tab = pom;

    return ret;
}

tabbit & tabbit::operator ^= (const tabbit &tb) {
    int new_length;
    if (len >= tb.len) new_length = len;
    else new_length = tb.len;

    uint64_t * pom = new uint64_t [new_length];

    int i = 0;
    while (i < new_length) {
        if (new_length == len) {
            if (i > tb.len) pom[i] = tab[i];
            else pom[i] = tab[i] ^ tb.tab[i-(len-tb.len)];
        }
        else {
            if (i > len) pom[i] = tb.tab[i];
            else pom[i] = tab[i-(tb.len-len)] ^ tb.tab[i];
        }
        i++;
    }

    delete[] tab;
    tab = pom;
    len = new_length;

    return *this;
}

tabbit & tabbit::operator ! () {
    for (int i = 0; i < len; i++) tab[i] = 18446744073709551615 - tab[i];
    return *this;
}
