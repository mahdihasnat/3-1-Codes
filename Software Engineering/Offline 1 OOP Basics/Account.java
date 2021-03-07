public abstract class Account {
    private final String name;
    private int balance;
    private int loan = 0;

    public Account(String name, int balance) {
        this.name = name;
        this.balance = balance;
    }

    public void deposit(int amount) throws Exception {
        if (amount < 0)
            throw new Exception("Transaction Failed! Amount cannot be negative");
        incrementBalance(amount);
        System.out.println(amount + "$$ deposited; current balance " + getBalance() + "$");
    }

    public void withdraw(int amount) throws Exception {
        if (amount < 0)
            throw new Exception("Transaction Failed! Amount cannot be negative");
        decrementBalance(amount);
        System.out.println("Successful transaction;" + amount + "$ debited from " + getName() + "'s account; Current balance " + getBalance() + "$");
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

    public String getName() {
        return name;
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
