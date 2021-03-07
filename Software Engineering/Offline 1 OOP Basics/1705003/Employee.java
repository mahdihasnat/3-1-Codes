

public abstract class Employee extends User {


    public Employee(String name) {
        super(name);
    }

    public void Lookup(Account acc) {
        System.out.println("Permission Denied");
    }

    public boolean ApproveLoan(Bank bank, LoanRequest loanRequest) {
        System.out.println("Permission Denied");
        return false;
    }

    public void SeeInternalFund(Bank bank) {
        System.out.println("Permission Denied");
    }

    public void ChangeInterestRate(String accountType, float new_interest_rate_per_cent) {
        System.out.println("Permission Denied");
    }


}


