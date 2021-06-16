#ifndef ADDED_SCOPETABLE
#define ADDED_SCOPETABLE

#include "SymbolInfo.h"

#include <bits/stdc++.h>
using namespace std;

/*
        REMINDER
        cascaded delete is used , everything this object points also get deleted 
*/
template <typename valueType>
class ScopeTable
{

private:
    static int total_bucket;

    SymbolInfo<valueType> **bucket;
    ScopeTable<valueType> *parentScopeTable;
    string id;

public:
    ScopeTable(ScopeTable<valueType> *parentScopeTable = 0, int current_id = 1) : parentScopeTable(parentScopeTable)
    {
        bucket = new SymbolInfo<valueType> *[total_bucket];
        for (int i = 0; i < total_bucket; i++)
            bucket[i] = nullptr;
        if (parentScopeTable)
            id = parentScopeTable->getId() + '.';
        id += to_string(current_id);
    }
    ~ScopeTable()
    {
        for (int i = 0; i < total_bucket; i++)
            delete bucket[i];
        delete[] bucket;

        if (parentScopeTable)
            delete parentScopeTable;
    }

    bool insert(SymbolInfo<valueType> *symbolinfo) /// symbol info connected to scopetable
    {
        int buncket_index = symbolinfo->hashCode() % total_bucket;
        SymbolInfo<valueType> *previous_symbolinfo = bucket[buncket_index];
        int index = 0;

        while (previous_symbolinfo)
        {
            if (previous_symbolinfo->getName() == symbolinfo->getName())
            {
                //cerr << (*previous_symbolinfo) << " already exists in current ScopeTable" << endl;
                //cerr << (*symbolinfo) << " found in ScopTable " << getId() << " at position " << buncket_index << ", " << index << "" << endl;
                delete symbolinfo;
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

        //cerr << "Inserted in ScopeTable# " << getId() << " at position " << buncket_index << ", " << index << endl;
        return true;
    }
    bool insert(string key, valueType value)
    {
        return insert(new SymbolInfo<valueType>(key, value));
    }

    SymbolInfo<valueType> *find(string key)
    {
        int bucket_index = SymbolInfo<valueType>::hashCodeImpl(key)% total_bucket;
        SymbolInfo<valueType> *currentSymbolInfo = bucket[bucket_index];
        int index = 0;
        while (currentSymbolInfo)
        {
            if (currentSymbolInfo->getName() == key)
            {
                //cerr << (*currentSymbolInfo) << " found in ScopeTable# " << getId() << " at " << bucket_index << " , " << index << endl;
                return currentSymbolInfo;
            }
            index++;
            currentSymbolInfo = currentSymbolInfo->getNextSymbolInfo();
        }
        return nullptr;
    }
    bool erase(string key)
    {
        int bucket_index = SymbolInfo<valueType>(key, valueType()).hashCode() % total_bucket;
        SymbolInfo<valueType> *currentSymbolInfo = bucket[bucket_index];
        SymbolInfo<valueType> *previousSymbolInfo = nullptr;
        int index = 0;
        while (currentSymbolInfo)
        {
            if (currentSymbolInfo->getName() == key)
            {
                cerr << "Found in ScopeTable# " << getId() << " at position " << bucket_index << ", " << index << endl;

                SymbolInfo<valueType> *nextSymbolInfo = currentSymbolInfo->getNextSymbolInfo();

                if (previousSymbolInfo)
                    previousSymbolInfo->setNextSymbolInfo(nextSymbolInfo);
                else
                    bucket[bucket_index] = nextSymbolInfo;

                currentSymbolInfo->setNextSymbolInfo(nullptr); /// !! IMPORTANT : otherwise chain will deleted
                delete currentSymbolInfo;

                cerr << "Deleted Entry " << bucket_index << ", " << index << " from current ScopeTable" << endl;

                return 1;
            }

            previousSymbolInfo = currentSymbolInfo;
            currentSymbolInfo = currentSymbolInfo->getNextSymbolInfo();
            index++;
        }
        cerr << "SymbolInfo not found in current ScopeTable #" << getId() << endl;
        return 0;
    }

    void printNonEmptyBuckets(ostream &os)
    {
        os << "\nScopeTable # " << getId() << endl;
        for (int i = 0; i < ScopeTable::total_bucket; i++)
        {
            if (bucket[i])
            {
                os << " "<<i << " --> ";
                SymbolInfo<valueType> *currentSymbolInfo = bucket[i];
                while (currentSymbolInfo)
                {
                    os << (*currentSymbolInfo) << " " ;
                    currentSymbolInfo = currentSymbolInfo->getNextSymbolInfo();
                }
                os << endl;
            }
        }
        os<<endl;
        os<<endl;
    }

    friend ostream &operator<<(ostream &os, ScopeTable &st)
    {
        os << "\nScopeTable # " << st.getId() << endl;
        for (int i = 0; i < ScopeTable::total_bucket; i++)
        {
            os << i << " --> ";
            SymbolInfo<valueType> *currentSymbolInfo = st.bucket[i];
            while (currentSymbolInfo)
            {
                os << " " << (*currentSymbolInfo);
                currentSymbolInfo = currentSymbolInfo->getNextSymbolInfo();
            }
            os << endl;
        }
        os<<endl;
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

    void setParentScopeTable(ScopeTable<valueType> *parentScopeTable)
    {
        this->parentScopeTable = parentScopeTable;
    }

    ScopeTable<valueType> *getParentScopeTable()
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

template <typename valueType>
int ScopeTable<valueType>::total_bucket = 1;

#endif