#ifndef ADDED_SYMBOLINFO
#define ADDED_SYMBOLINFO

#include <string>
using namespace std;
/*
        Stores (key ,value , nextSymbolInfo pointer in hashtable)
        Actually represents List of SymbolInfo , so when deleted everething this Object points to also deleted
    
        REMINDER
        cascaded delete is used , everything this object points also get deleted 
    */
template < typename valueType >
class SymbolInfoChain
{

private:
    string key;
    valueType value;
    SymbolInfoChain<valueType> *nextSymbolInfo;

public:
    SymbolInfoChain(string key, valueType value, SymbolInfoChain *nextSymbolInfo = nullptr) : key(key), value(value), nextSymbolInfo(nextSymbolInfo)
    {
    }
    ~SymbolInfoChain()
    {
        if (nextSymbolInfo)
            delete nextSymbolInfo;
    }
    int hashCode()
    {
        int total_ascii = 0;
        for (char c : key)
            total_ascii += c;
        return total_ascii;
    }

    string getName() const
    {
        return key;
    }
    valueType getType() const
    {
        return value;
    }

    SymbolInfoChain<valueType> *getNextSymbolInfo() const
    {
        return nextSymbolInfo;
    }
    void setNextSymbolInfo(SymbolInfoChain<valueType> *nextSymbolInfo)
    {
        this->nextSymbolInfo = nextSymbolInfo;
    }

    friend ostream &operator<<(ostream &os, const SymbolInfoChain &sym)
    {
        os << "< " << sym.getName() << " : " << sym.getType() << " >";
        return os;
    }
};

#endif