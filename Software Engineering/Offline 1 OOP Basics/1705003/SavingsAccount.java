
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

    public SavingsAccount(String name, Integer deposit) {
        super(name, deposit);
    }

    @Override
    public boolean deposit(int amount) {
        return super.deposit(amount);
    }

    @Override
    public boolean withdraw(int amount) {
        if (getBalance() - amount < 1000) {
            System.out.println("Invalid transaction; current balance " + getBalance() + "$ ; account cannot not have less than 1000$ after withdrawal");
            return false;
        }
        return super.withdraw(amount);
    }
}
