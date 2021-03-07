public class ManagingDirector extends Officer {

    public ManagingDirector(String name) {
        super(name);
    }

    @Override
    public void SeeInternalFund(Bank bank) {
        System.out.println("Current Internal Fund " + bank.getInternalFund() + "$");
    }

    @Override
    public void ChangeInterestRate(String accountType, float new_interest_rate_per_cent) {
        switch (accountType.toLowerCase()) {
            case "student":
                StudentAccount.setInterest_rate_per_cent(new_interest_rate_per_cent);
                break;
            case "savings":
                SavingsAccount.setInterest_rate_per_cent(new_interest_rate_per_cent);
                break;
            case "fixed":
                FixedAccount.setInterest_rate_per_cent(new_interest_rate_per_cent);
                break;
            default:
                System.out.println("Invalid AccountType! ");
                return;
        }
        System.out.println("Interest rate of " + accountType + "  changed to " + new_interest_rate_per_cent + "% ");
    }
}