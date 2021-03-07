public class ManagingDirector extends Officer {

    public ManagingDirector(String name) {
        super(name);
    }

    @Override
    public void SeeInternalFund(Bank bank) throws Exception {
        System.out.println("Internal Fund " + bank.getInternalFund() + "$");
    }

    @Override
    public void ChangeInterestRate(String accountType, float new_interest_rate_per_cent) throws Exception {
        if (accountType.toLowerCase().equals("student"))
            StudentAccount.setInterest_rate_per_cent(new_interest_rate_per_cent);
        else if (accountType.toLowerCase().equals("savings"))
            SavingsAccount.setInterest_rate_per_cent(new_interest_rate_per_cent);
        else if (accountType.toLowerCase().equals("fixed"))
            FixedAccount.setInterest_rate_per_cent(new_interest_rate_per_cent);
        else throw new Exception("Account Type not found");
        System.out.println("Interest rate of " + accountType + "  changed to " + new_interest_rate_per_cent + "% ");
    }
}