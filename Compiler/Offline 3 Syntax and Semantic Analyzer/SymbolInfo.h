#ifndef ADDED_SYMBOLINFO
#define ADDED_SYMBOLINFO

#include <bits/stdc++.h>
using namespace std;

#include "Info.h"

/*
        Stores (key ,value , nextSymbolInfo pointer in hashtable)
        Actually represents List of SymbolInfo , so when deleted everething this Object points to also deleted
    
        REMINDER
        cascaded delete is used , everything this object points also get deleted 
    */
template <typename valueType>
class SymbolInfo
{

private:
    string key;
    valueType value;
    SymbolInfo<valueType> *nextSymbolInfo;

public:
    SymbolInfo(string key, valueType value, SymbolInfo *nextSymbolInfo = nullptr) : key(key), value(value), nextSymbolInfo(nextSymbolInfo)
    {
    }

    SymbolInfo(const SymbolInfo<valueType> & ref) : key(ref.key) , value(ref.value) , nextSymbolInfo(nullptr)
    {
    }
    
    SymbolInfo( SymbolInfo<valueType> * ref) : key(ref->key) , value(ref->value) , nextSymbolInfo(nullptr)
    {
    }


    ~SymbolInfo()
    {
        if (nextSymbolInfo)
            delete nextSymbolInfo;
    }
    int hashCode()
    {
        return hashCodeImpl(key);
    }

    static int hashCodeImpl(string key)
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
    valueType * getTypeLocation()
    {
        return &value;
    }

    void push_back(SymbolInfo<valueType> * newSymbolInfo)
    {
        SymbolInfo<valueType> * prev  , * now ;
        now = this;
        while (now)
        {
            prev = now;
            now = now->getNextSymbolInfo();
            
        }
        prev ->setNextSymbolInfo(newSymbolInfo);
    }

    SymbolInfo<valueType> *getNextSymbolInfo() const
    {
        return nextSymbolInfo;
    }
    void setNextSymbolInfo(SymbolInfo<valueType> *nextSymbolInfo)
    {
        this->nextSymbolInfo = nextSymbolInfo;
    }

    friend ostream &operator<<(ostream &os, const SymbolInfo &sym)
    {
        os << string("< ") << sym.getName() << " : " << sym.getType() << ">";
        return os;
    }
};

#endif