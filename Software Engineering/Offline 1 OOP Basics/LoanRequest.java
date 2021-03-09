public class LoanRequest {
    private final Account account;
    private final int amount;

    public LoanRequest(Account account, int amount) {
        this.account = account;
        this.amount = amount;
    }

    public boolean approve(Bank bank) {
        if (amount <= bank.getInternalFund()) {
            bank.decrementInternalFund(amount);
            account.incrementLoanAmount(amount);
            account.incrementBalance(amount);
            System.out.println(amount + "$ loan for " + account + " Approved.");
            return true;
        } else {
            System.out.println("loan request for " + account + " (" + amount + "$) declined. not enough money for loan in internal fund");
            return false;
        }
    }
}
