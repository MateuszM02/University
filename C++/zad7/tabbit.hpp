#include<iostream>
#include<math.h>

using namespace std;

namespace obliczenia {
class tabbit {
    static const int word_size;
    friend istream & operator >> (istream &st, tabbit &tb);
    friend ostream & operator << (ostream &st, const tabbit &tb);

    protected:
    int len;
    uint64_t * tab;

    public:
    explicit tabbit (int s);
    explicit tabbit (uint64_t tb);
    ~tabbit ();

    tabbit (const tabbit &tb); // copying constructor
    tabbit & operator = (const tabbit &tb);

    tabbit (tabbit &&tb); //moving constructor
    tabbit & operator = (tabbit &&tb);

    private:
    bool read (int i) const;
    void write (int i, bool b);

    public:
    bool operator [] (int i) const; //index for constant tables
    uint64_t operator [] (int i);
    inline int size() const;

    tabbit operator |  (const tabbit &tb);
    tabbit & operator |= (const tabbit &tb);

    tabbit operator &  (const tabbit &tb);
    tabbit & operator &= (const tabbit &tb);

    tabbit operator ^  (const tabbit &tb);
    tabbit & operator ^= (const tabbit &tb);

    tabbit & operator !  ();
};
}
