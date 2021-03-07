import java.util.ArrayList;

public class Bank {
    private final ArrayList<User> users;
    private ArrayList<LoanRequest> loan_requests;
    private User currentUser;

    private int internalFund = 1000000;

    Bank() {
        currentUser = null;
        users = new ArrayList<>();
        users.add(new ManagingDirector("MD"));
        for (int i = 1; i <= 2; i++) users.add(new Officer("S" + i));
        for (int i = 1; i <= 5; i++) users.add(new Cashier("C" + i));

        loan_requests = new ArrayList<>();

        System.out.println("Bank Created; MD, S1, S2, C1, C2, C3, C4, C5 created");
    }

    public Account getAccount(String name) {
        for (User u : users)
            if (u.getName().equals(name))
                return (Account) u;
        return null;
    }


    public boolean addAccount(Account ac) {
        for (User u : users)
            if (u.getName().equals(ac.getName())) {
                System.out.println("Account Creation failed!User already Exists with same name");
                return false;
            }
        users.add(ac);
        System.out.println(ac.getClass().getName() + " for " + ac.getName() + " Created; initial balance " + ac.getBalance() + "$");
        return true;
    }

    public boolean createAccount(String name, String type, int initialDeposit) throws Exception {
        Account ac;
        if (type.equalsIgnoreCase("student"))
            ac = new StudentAccount(name, initialDeposit);
        else if (type.equalsIgnoreCase("fixed"))
            ac = new FixedAccount(name, initialDeposit);
        else ac = new SavingsAccount(name, initialDeposit);
        if (addAccount(ac)) {
            currentUser = ac;
            return true;
        } else return false;
    }

    public boolean deposit(int amount) {
        if (currentUser != null && currentUser instanceof Account) {
            Account ac = (Account) currentUser;
            return ac.deposit(amount);
        } else {
            System.out.println("Invalid Current User , Current User doesn't have Account! " + currentUser);
            return false;
        }
    }

    public boolean withdraw(int amount) {
        if (currentUser != null && currentUser instanceof Account) {
            Account ac = (Account) currentUser;
            return ac.withdraw(amount);
        } else {
            System.out.println("Invalid Current User , Current User doesn't have Account! " + currentUser);
            return false;
        }
    }

    public boolean addLoanRequest(int amount) {
        if (currentUser != null && currentUser instanceof Account) {
            Account ac = (Account) currentUser;
            if (amount < 0) {
                System.out.println("Amount cannot be negative");
                return false;
            }
            if (ac.getMaximumAllowableLoan() < amount) {
                System.out.println("Invalid request! Amount is greater than Maximum allowable loan for " + ac.getClass().getName() + " (" + ac.getMaximumAllowableLoan() + ")$");
                return false;
            }
            loan_requests.add(new LoanRequest(ac, amount));
            System.out.println("loan request successful, sent for approval");
            return true;
        } else {
            System.out.println("Invalid Current User , Current User doesn't have Account! " + currentUser);
            return false;
        }
    }

    public void query() {
        if (currentUser != null && currentUser instanceof Account) {
            Account ac = (Account) currentUser;
            ac.query();
        } else {
            System.out.println("Invalid Current User , Current User doesn't have Account! " + currentUser);
        }
    }

    public void open(String name) {
        for (User u : users)
            if (u.getName().equals(name)) {
                System.out.println("Welcome " + u);
                currentUser = u;

                if (currentUser instanceof Employee && !loan_requests.isEmpty()) {
                    System.out.println("There are loan approvals pending");
                }

                return;
            }
        System.out.println("No user found named " + name);
    }

    public void close() {
        System.out.println("Transaction closed for " + currentUser);
        currentUser = null;
    }

    public void inc() {
        for (User u : users) {
            if (u instanceof Account)
                ((Account) u).incrementYear();
        }
        System.out.println("One Year passed");
    }

    public void lookUp(String name) {
        if (currentUser != null && currentUser instanceof Employee) {
            Employee emp = (Employee) currentUser;
            Account ac = getAccount(name);
            if (ac == null)
                System.out.println("No Account Found named " + name);
            else
                emp.Lookup(ac);
        } else {
            System.out.println("Current User is not an employee #" + currentUser);
        }
    }

    public void ApproveLoan() {
        if (currentUser != null && currentUser instanceof Employee) {
            Employee emp = (Employee) currentUser;
            ArrayList<LoanRequest> failed_transaction = new ArrayList<>();
            for (LoanRequest lr : loan_requests) {
                if (!emp.ApproveLoan(this, lr)) {
                    failed_transaction.add(lr);
                }
            }
            loan_requests = failed_transaction;
        } else {
            System.out.println("Current User is not an employee #" + currentUser);
        }
    }

    public void changeInterestRate(String accountType, float new_interest_rate_percent) {
        if (currentUser != null && currentUser instanceof Employee) {
            Employee emp = (Employee) currentUser;
            emp.ChangeInterestRate(accountType, new_interest_rate_percent);
        } else {
            System.out.println("Current User is not an employee #" + currentUser);
        }
    }

    public void seeInternalFund() {
        if (currentUser != null && currentUser instanceof Employee) {
            Employee emp = (Employee) currentUser;
            emp.SeeInternalFund(this);
        } else {
            System.out.println("Current User is not an employee #" + currentUser);
        }
    }


    public int getInternalFund() {
        return internalFund;
    }

    public void decrementInternalFund(int amount) {
        internalFund -= amount;
    }

}
