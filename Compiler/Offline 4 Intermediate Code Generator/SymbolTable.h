#ifndef ADDED_SYMBOLTABLE
#define ADDED_SYMBOLTABLE

#include "ScopeTable.h"

extern ofstream logstream;

template <typename valueType>
class SymbolTable
{
private:
    ScopeTable<valueType> *currentScopeTable;
    int nextNewChild;

public:
    SymbolTable()
    {
        currentScopeTable = new ScopeTable<valueType>();
        nextNewChild = 1;
    }
    ~SymbolTable()
    {
        if (currentScopeTable)
            delete currentScopeTable;
    }

    bool isGlobalScope()
    {
        if (currentScopeTable == nullptr)
            return false;
        else
            return currentScopeTable->isGlobalScopeTable();
    }

    void enterScope()
    {
        ScopeTable<valueType> *parentScopeTable = currentScopeTable;
        currentScopeTable = new ScopeTable<valueType>(parentScopeTable, nextNewChild);
        nextNewChild = 1;
        //logstream << "\nNew ScopeTable with id " << currentScopeTable->getId() << " created" << endl;
    }
    void exitScope()
    {

        if (currentScopeTable)
        {
            nextNewChild = currentScopeTable->getCurrentId() + 1;

            ScopeTable<valueType> *parentScopeTable = currentScopeTable->getParentScopeTable();

            //logstream << "\nScopeTable with id " << currentScopeTable->getId() << " removed" << endl;
            currentScopeTable->setParentScopeTable(nullptr); /// !! IMPORTANT otherwise entire symboltable will be lost
            delete currentScopeTable;

            currentScopeTable = parentScopeTable;
        }
        else
        {
            logstream << "\nCurrent ScopeTable is Empty!" << endl;
        }
    }

    SymbolInfo<valueType> *lookUp(string key)
    {
        ScopeTable<valueType> *current = getCurrentScopeTable();
        while (current)
        {
            SymbolInfo<valueType> *now = current->find(key);
            if (now)
                return now;
            current = current->getParentScopeTable();
        }
        //cerr << key << " not found in SymbolTable" << endl;
        return nullptr;
    }
    bool insert(string key, valueType type)
    {
        if (currentScopeTable)
            return currentScopeTable->insert(key, type);
        else
        {
            cerr << "Current Scope is empty!" << endl;
            return false;
        }
    }

    bool insert(SymbolInfo<valueType> *symbolinfo) /// symbolinfo stayed in  symboltable / scopetable
    {
        if (currentScopeTable)
            return currentScopeTable->insert(symbolinfo);
        else
        {
            return false;
        }
    }

    bool erase(string key)
    {
        if (currentScopeTable)
            return currentScopeTable->erase(key);
        else
        {
            cerr << "Current Scope is empty!" << endl;
            return false;
        }
    }

    ScopeTable<valueType> *getCurrentScopeTable() const
    {
        return currentScopeTable;
    }

    void printCurrentScopeTable()
    {

        if (currentScopeTable)
            cerr << (*currentScopeTable) << endl;
        else
            cerr << "Current ScopeTable is empty!" << endl;
    }

    void printNonEmptyBuckets(ostream &os)
    {
        os << endl;
        ScopeTable<valueType> *current = getCurrentScopeTable();
        while (current)
        {
            current->printNonEmptyBuckets(os);
            current = current->getParentScopeTable();
        }
    }

    friend ostream &operator<<(ostream &os, const SymbolTable &st) //print all scope table
    {
        ScopeTable<valueType> *current = st.getCurrentScopeTable();
        while (current)
        {
            os << (*current) << endl;
            current = current->getParentScopeTable();
        }
        return os;
    }
};

#endif
