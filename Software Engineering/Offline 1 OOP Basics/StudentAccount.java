public class StudentAccount extends Account {

    private static float interest_rate_per_cent;

    static {
        interest_rate_per_cent = 5.0F;
    }

    public static void setInterest_rate_per_cent(float interest_rate_per_cent) {
        StudentAccount.interest_rate_per_cent = interest_rate_per_cent;
    }

    @Override
    public float getInterest_rate_per_cent() {
        return interest_rate_per_cent;
    }

    @Override
    public int getMaximumAllowableLoan() {
        return 1000;
    }

    public StudentAccount(String name, int deposit) {
        super(name, deposit);
    }

    @Override
    public void deposit(int amount) throws Exception {
        super.deposit(amount);
    }

    @Override
    public void withdraw(int amount) throws Exception {
        if (amount > 10000)
            throw new Exception("Invalid transaction; A student account cannot withdraw more than 10,000$ in one transaction");
        if (getBalance() < amount)
            throw new Exception("Invalid transaction; current balance " + getBalance() + "$");
        super.withdraw(amount);
    }

    @Override
    public int getYearlyServiceCharge() {
        return 0;
    }
}