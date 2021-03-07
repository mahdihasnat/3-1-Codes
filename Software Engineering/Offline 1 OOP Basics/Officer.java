public class Officer extends Cashier {
    public Officer(String name) {
        super(name);
    }

    @Override
    public void ApproveLoan(Bank bank, Account acc, int amount) throws Exception {
        if (bank.getInternalFund() < amount) {
            throw new Exception("loan request for " + acc + " (" + amount + "$) declined. not enough money for loan in internal fund");
        }
        bank.decrementInternalFund(amount);
        acc.incrementLoan(amount);
        acc.incrementBalance(amount);
        System.out.println(amount + "$ loan for " + acc + " Approved.");
    }
}