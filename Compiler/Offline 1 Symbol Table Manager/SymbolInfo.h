#ifndef ADDED_SYMBOLINFO
#define ADDED_SYMBOLINFO

#include <string>
using namespace std;
/*

        Actually represents List of SymbolInfo , so when deleted everething this Object points to also deleted
    
        REMINDER
        cascaded delete is used , everything this object points also get deleted 
    */
class SymbolInfo
{

private:
    string name;
    string type;
    SymbolInfo *nextSymbolInfo;

public:
    SymbolInfo(string name, string type, SymbolInfo *nextSymbolInfo = nullptr) : name(name), type(type), nextSymbolInfo(nextSymbolInfo)
    {
    }
    /*
        REMINDER
        cascaded delete is used , everything this object points also get deleted 
    */
    ~SymbolInfo()
    {
        if (nextSymbolInfo)
            delete nextSymbolInfo;
    }
    int hashCode()
    {
        int total_ascii = 0;
        for (char c : name)
            total_ascii += c;
        return total_ascii;
    }

    string getName() const
    {
        return name;
    }
    string getType() const
    {
        return type;
    }

    SymbolInfo *getNextSymbolInfo() const
    {
        return nextSymbolInfo;
    }
    void setNextSymbolInfo(SymbolInfo *nextSymbolInfo)
    {
        this->nextSymbolInfo = nextSymbolInfo;
    }

    friend ostream &operator<<(ostream &os, const SymbolInfo &sym)
    {
        os << "< " << sym.getName() << " : " << sym.getType() << " >";
        return os;
    }
};

#endif