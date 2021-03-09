public class StudentAccount extends Account {

    private static float interest_rate_per_cent;

    static {
        interest_rate_per_cent = 5.0F;
    }

    public StudentAccount(String name, int deposit) {
        super(name, deposit);
    }

    @Override
    protected float getInterest_rate_per_cent() {
        return interest_rate_per_cent;
    }

    public static void setInterest_rate_per_cent(float interest_rate_per_cent) {
        StudentAccount.interest_rate_per_cent = interest_rate_per_cent;
    }

    @Override
    public int getMaximumAllowableLoan() {
        return 1000;
    }

    @Override
    public boolean deposit(int amount) {
        return super.deposit(amount);
    }

    @Override
    public boolean withdraw(int amount) {
        if (amount > 10000) {
            System.out.println("Invalid transaction; A student account cannot withdraw more than 10,000$ in one transaction");
            return false;
        }
        return super.withdraw(amount);
    }

    @Override
    protected int getYearlyServiceCharge() {
        return 0;
    }
}