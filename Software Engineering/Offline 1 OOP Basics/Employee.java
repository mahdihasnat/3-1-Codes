

public abstract class Employee {
    private final String name;

    public Employee(String name) {
        this.name = name;
    }

    public void Lookup(Account acc) throws Exception {
        throw new Exception("Permission Denied");
    }

    public void ApproveLoan(Bank bank, Account acc, int amount) throws Exception {
        throw new Exception("Permission Denied");
    }

    public void SeeInternalFund(Bank bank) throws Exception {
        throw new Exception("Permission Denied");
    }

    public void ChangeInterestRate(String accountType, float new_interest_rate_per_cent) throws Exception {
        throw new Exception("Permission Denied");
    }


    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return getName();
    }


}


