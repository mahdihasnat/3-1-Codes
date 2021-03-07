
public class SavingsAccount extends Account {

    private static float interest_rate_per_cent;

    static {
        interest_rate_per_cent = 10.0F;
    }

    public static void setInterest_rate_per_cent(float interest_rate_per_cent) {
        SavingsAccount.interest_rate_per_cent = interest_rate_per_cent;
    }

    @Override
    public float getInterest_rate_per_cent() {
        return interest_rate_per_cent;
    }

    @Override
    public int getMaximumAllowableLoan() {
        return 10000;
    }

    public SavingsAccount(String name, int deposit) {
        super(name, deposit);
    }

    @Override
    public void deposit(int amount) throws Exception {
        super.deposit(amount);
    }

    @Override
    public void withdraw(int amount) throws Exception {
        if (getBalance() - amount < 1000)
            throw new Exception("Invalid transaction; current balance " + getBalance() + "$ ; account cannot not have less than 1000$ after withdrawal");
        super.withdraw(amount);
    }
}
