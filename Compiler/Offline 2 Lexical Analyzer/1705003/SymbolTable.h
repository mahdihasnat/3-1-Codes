#ifndef ADDED_SYMBOLTABLE
#define ADDED_SYMBOLTABLE

#include "ScopeTable.h"

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

    void enterScope()
    {
        ScopeTable<valueType> *parentScopeTable = currentScopeTable;
        currentScopeTable = new ScopeTable<valueType>(parentScopeTable, nextNewChild);
        nextNewChild = 1;
        cerr << "New ScopeTable with id " << currentScopeTable->getId() << " created" << endl;
    }
    void exitScope()
    {

        if (currentScopeTable)
        {
            nextNewChild = currentScopeTable->getCurrentId() + 1;

            ScopeTable<valueType> *parentScopeTable = currentScopeTable->getParentScopeTable();

            cerr << "ScopeTable with id " << currentScopeTable->getId() << " removed" << endl;
            currentScopeTable->setParentScopeTable(nullptr); /// !! IMPORTANT otherwise entire symboltable will be lost
            delete currentScopeTable;

            currentScopeTable = parentScopeTable;
        }
        else
        {
            cerr << "Current ScopeTable is Empty!" << endl;
        }
    }

    SymbolInfoChain<valueType> *lookUp(string key)
    {
        ScopeTable<valueType> *current = getCurrentScopeTable();
        while (current)
        {
            SymbolInfoChain<valueType> *now = current->find(key);
            if (now)
                return now;
            current = current->getParentScopeTable();
        }
        cerr << key << " not found in SymbolTable" << endl;
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

    void printNonEmptyBuckets(ostream & os)
    {
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