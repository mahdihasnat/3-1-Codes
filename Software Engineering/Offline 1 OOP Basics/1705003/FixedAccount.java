
public class FixedAccount extends Account {
    private int allowable_withdrawal_amount = 0;

    private static float interest_rate_per_cent;

    static {
        interest_rate_per_cent = 15;
    }

    @Override
    public float getInterest_rate_per_cent() {
        return interest_rate_per_cent;
    }

    public static void setInterest_rate_per_cent(float interest_rate_per_cent) {
        FixedAccount.interest_rate_per_cent = interest_rate_per_cent;
    }

    public FixedAccount(String name, int initial_deposit) throws Exception {
        super(name, initial_deposit);
        if (initial_deposit < 100000)
            throw new Exception("Error creating account. Initial deposit is less than  100,000$.");
    }

    @Override
    public boolean deposit(int amount) {
        if (amount < 50000) {
            System.out.println("deposit amount for fixed account is less than 50,000$");
            return false;
        }
        return super.deposit(amount);
    }

    @Override
    public boolean withdraw(int amount) {
        if (getBalance() < amount) {
            System.out.println("Invalid transaction; current balance " + getBalance() + "$");
            return false;
        }
        if (getAllowable_withdrawal_amount() < amount) {
            System.out.println("Invalid transaction;One year didn't reach to withdraw money ,withdraw allowable amount" + allowable_withdrawal_amount + "$");
            return true;
        }
        decrementAllowable_withdrawal_amount(amount);
        return super.withdraw(amount);
    }

    @Override
    public void query() {
        System.out.println("Maximum withdrawable balance for " + getName() + " is " + getAllowable_withdrawal_amount() + "$");
        super.query();
    }

    @Override
    public void incrementYear() {
        super.incrementYear();
        setAllowable_withdrawal_amount(getBalance());
    }

    @Override
    public int getMaximumAllowableLoan() {
        return 100000;
    }

    public void decrementAllowable_withdrawal_amount(int amount) {
        allowable_withdrawal_amount -= amount;
    }

    public int getAllowable_withdrawal_amount() {
        return allowable_withdrawal_amount;
    }

    public void setAllowable_withdrawal_amount(int allowable_withdrawal_amount) {
        this.allowable_withdrawal_amount = allowable_withdrawal_amount;
    }
}

