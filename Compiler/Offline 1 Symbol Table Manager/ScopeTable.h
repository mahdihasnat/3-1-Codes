#ifndef ADDED_SCOPETABLE
#define ADDED_SCOPETABLE

#include "SymbolInfo.h"

#include <bits/stdc++.h>
using namespace std;

/*
        REMINDER
        cascaded delete is used , everything this object points also get deleted 
*/
class ScopeTable
{
    
private:
    static int total_bucket;

    SymbolInfo **bucket;
    ScopeTable *parentScopeTable;
    string id;

public:
    ScopeTable(ScopeTable *parentScopeTable = 0, int current_id = 1) : parentScopeTable(parentScopeTable)
    {
        bucket = new SymbolInfo *[total_bucket];
        for (int i = 0; i < total_bucket; i++)
            bucket[i] = nullptr;
        if (parentScopeTable)
            id = parentScopeTable->getId() + '.';
        id += to_string(current_id);
    }
    /*
        REMINDER
        cascaded delete is used , everything this object points also get deleted 
    */
    ~ScopeTable()
    {
        for (int i = 0; i < total_bucket; i++)
            delete bucket[i];
        delete[] bucket;

        if (parentScopeTable)
            delete parentScopeTable;
    }

    bool insert(SymbolInfo *symbolinfo)
    {
        int buncket_index = symbolinfo->hashCode() % total_bucket;
        SymbolInfo *previous_symbolinfo = bucket[buncket_index];
        int index = 0;

        while (previous_symbolinfo)
        {
            if (previous_symbolinfo->getName() == symbolinfo->getName())
            {
                cout << (*symbolinfo) << " already exists in current ScopeTable" << endl;
                //cout << (*symbolinfo) << " found in ScopTable " << getId() << " at position " << buncket_index << ", " << index << "" << endl;
                return false;
            }

            if (previous_symbolinfo->getNextSymbolInfo())
            {
                index++;
                previous_symbolinfo = previous_symbolinfo->getNextSymbolInfo();
            }
            else
            {
                index++;
                break;
            }
        }
        if (index == 0)
            bucket[buncket_index] = symbolinfo;
        else
            previous_symbolinfo->setNextSymbolInfo(symbolinfo);

        cout << "Inserted in ScopeTable# " << getId() << " at position " << buncket_index << ", " << index << endl;
        return true;
    }
    bool insert(string name, string type)
    {
        return insert(new SymbolInfo(name, type));
    }

    SymbolInfo *find(string name)
    {
        int bucket_index = SymbolInfo(name, "").hashCode() % total_bucket;
        SymbolInfo *currentSymbolInfo = bucket[bucket_index];
        int index = 0;
        while (currentSymbolInfo)
        {
            if (currentSymbolInfo->getName() == name)
            {
                cout << (*currentSymbolInfo) << " found in ScopeTable# " << getId() << " at " << bucket_index << " , " << index << endl;
                return currentSymbolInfo;
            }
            index++;
            currentSymbolInfo = currentSymbolInfo->getNextSymbolInfo();
        }
        return nullptr;
    }
    bool erase(string name)
    {
        int bucket_index = SymbolInfo(name, "").hashCode() % total_bucket;
        SymbolInfo *currentSymbolInfo = bucket[bucket_index];
        SymbolInfo *previousSymbolInfo = nullptr;
        int index = 0;
        while (currentSymbolInfo)
        {
            if (currentSymbolInfo->getName() == name)
            {
                cout << "Found in ScopeTable# " << getId() << " at position " << bucket_index << ", " << index << endl;

                SymbolInfo *nextSymbolInfo = currentSymbolInfo->getNextSymbolInfo();
                currentSymbolInfo->setNextSymbolInfo(nullptr);

                if (previousSymbolInfo)
                    previousSymbolInfo->setNextSymbolInfo(nextSymbolInfo);
                else
                    bucket[bucket_index] = nextSymbolInfo;

                delete currentSymbolInfo;

                cout << "Deleted Entry " << bucket_index << ", " << index << " from current ScopeTable" << endl;

                return 1;
            }

            previousSymbolInfo = currentSymbolInfo;
            currentSymbolInfo = currentSymbolInfo->getNextSymbolInfo();
        }
        cout << "SymbolInfo not found in current ScopeTable" << endl;
        return 0;
    }

    friend ostream &operator<<(ostream &os, const ScopeTable &st)
    {
        os << "ScopeTable # " << st.getId() << endl;
        for (int i = 0; i < ScopeTable::total_bucket; i++)
        {
            os << i << " --> ";
            SymbolInfo *currentSymbolInfo = st.bucket[i];
            while (currentSymbolInfo)
            {
                os << " " << (*currentSymbolInfo);
                currentSymbolInfo = currentSymbolInfo->getNextSymbolInfo();
            }
            os << endl;
        }
        return os;
    }

    string getId() const
    {
        return id;
    }
    int getCurrentId()
    {
        int dividerPosition = id.find_last_of('.');
        if (dividerPosition == string::npos)
            dividerPosition = -1;
        int currentId = 0;
        for (int i = dividerPosition + 1; i < id.size(); i++)
            currentId *= 10, currentId += id[i] - '0';

        return currentId;
    }

    void setParentScopeTable(ScopeTable *parentScopeTable)
    {
        this->parentScopeTable = parentScopeTable;
    }

    ScopeTable *getParentScopeTable()
    {
        return parentScopeTable;
    }

    static int getTotalBucket()
    {
        return total_bucket;
    }

    static void setTotalBucket(int total_bucket)
    {
        ScopeTable::total_bucket = total_bucket;
    }
};

int ScopeTable::total_bucket = 1;

#endif