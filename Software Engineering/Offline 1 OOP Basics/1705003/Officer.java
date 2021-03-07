public class Officer extends Cashier {
    public Officer(String name) {
        super(name);
    }

    @Override
    public boolean ApproveLoan(Bank bank, LoanRequest loanRequest) {
        return loanRequest.approve(bank);
    }
}