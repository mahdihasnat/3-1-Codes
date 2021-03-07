public abstract class Account extends User {

    private int balance;
    private int loan = 0;

    public Account(String name, int balance) {
        super(name);
        this.balance = balance;
    }

    public boolean deposit(int amount) {
        if (amount < 0) {
            System.out.println("Transaction Failed! Amount cannot be negative");
            return false;
        }
        incrementBalance(amount);
        System.out.println(amount + "$$ deposited; current balance " + getBalance() + "$");
        return true;
    }

    public boolean withdraw(int amount) {
        if (amount < 0) {
            System.out.println("Transaction Failed! Amount cannot be negative");
            return false;
        }
        if (getBalance() < amount) {
            System.out.println("Invalid transaction; current balance " + getBalance() + "$");
            return false;
        }
        decrementBalance(amount);
        System.out.println("Successful transaction;" + amount + "$ debited from " + getName() + "'s account; Current balance " + getBalance() + "$");
        return true;
    }

    public void query() {
        System.out.println("Current balance for " + getName() + " is " + getBalance() + "$ , loan = " + getLoan() + "$");
    }

    public float getInterest_rate_per_cent() {
        return 0.0F;
    }

    public void incrementYear() {
        int interest = (int) (balance * getInterest_rate_per_cent() / 100.0);
        incrementBalance(interest);
        int loan_interest = loan * 10 / 100;
        decrementBalance(loan_interest);
        decrementBalance(getYearlyServiceCharge());
    }

    public int getYearlyServiceCharge() {
        return 500;
    }

    @Override
    public String toString() {
        return getName();
    }

    public int getBalance() {
        return balance;
    }

    protected void incrementBalance(int amount) {
        this.balance += amount;
    }

    protected void decrementBalance(int amount) {
        this.balance -= amount;
    }

    public int getLoan() {
        return loan;
    }

    public void incrementLoan(int amount) {
        this.loan += amount;
    }

    public int getMaximumAllowableLoan() {
        return 0;
    }
}
