#ifndef ADDED_SYMBOLTABLE
#define ADDED_SYMBOLTABLE
#define DBG(x) cout << (__LINE__) << " : " << (#x) << " -> " << (x) << "\n";
#include "ScopeTable.h"

class SymbolTable
{
private:
    ScopeTable *currentScopeTable;
    int nextNewChild;

public:
    SymbolTable()
    {
        currentScopeTable = new ScopeTable();
        nextNewChild = 1;
    }
    ~SymbolTable()
    {
        if(currentScopeTable)
            delete currentScopeTable;
    }

    void enterScope()
    {
        ScopeTable *parentScopeTable = currentScopeTable;
        currentScopeTable = new ScopeTable(parentScopeTable, nextNewChild);
        nextNewChild = 1;
        cout << "New ScopeTable with id " << currentScopeTable->getId() << " created" << endl;
    }
    void exitScope()
    {

        if (currentScopeTable)
        {
            nextNewChild = currentScopeTable->getCurrentId() + 1;
            ScopeTable *parentScopeTable = currentScopeTable->getParentScopeTable();
            cout << "ScopeTable with id " << currentScopeTable->getId() << " removed" << endl;
            currentScopeTable->setParentScopeTable(nullptr);
            delete currentScopeTable;
            currentScopeTable = parentScopeTable;
        }
        else
        {
            cout << "Current ScopeTable is Empty!" << endl;
        }
    }

    SymbolInfo * lookUp(string name)
    {
        ScopeTable * current = getCurrentScopeTable();
        while (current)
        {
            SymbolInfo * now = current->find(name);
            if(now)
                return now;
            current = current->getParentScopeTable();
        }
        cout<<name<<" not found in SymbolTable"<<endl;
        return nullptr;
        
    }
    bool insert(string name ,string type)
    {
        if(currentScopeTable)
            return currentScopeTable->insert(name , type);
        else 
        {
            cout<<"Current Scope is empty!"<<endl;
            return false;
        }
    }
    bool erase(string name)
    {
        if(currentScopeTable)
            return currentScopeTable->erase(name );
        else 
        {
            cout<<"Current Scope is empty!"<<endl;
            return false;
        }
    }

    ScopeTable *getCurrentScopeTable() const
    {
        return currentScopeTable;
    }

    friend ostream &operator<<(ostream &os, const SymbolTable &st)
    {
        ScopeTable *current = st.getCurrentScopeTable();
        while (current)
        {
            os << (*current) << endl;
            current = current->getParentScopeTable();
        }
        return os;
    }
};

#endif
