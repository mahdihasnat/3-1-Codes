import java.util.ArrayList;
import java.util.Scanner;

public class Bank {
    private final ArrayList<Account> accounts;
    private final Employee[] employees;
    private final ArrayList<Account> loan_request_accounts;
    private final ArrayList<Integer>  loan_request_amounts;

    private int internalFund = 1000000;

    Bank() {
        employees = new Employee[8];
        int now = 0;
        employees[now++] = new ManagingDirector("MD");
        for (int i = 1; i <= 2; i++) employees[now++] = new Officer("S" + i);
        for (int i = 1; i <= 5; i++) employees[now++] = new Cashier("C" + i);

        accounts = new ArrayList<>();
        loan_request_accounts = new ArrayList<>();
        loan_request_amounts = new ArrayList<>();

        System.out.println("Bank Created; MD, S1, S2, C1, C2, C3, C4, C5 created");
    }

    public Account getAccount(String name) {
        for (Account a : accounts)
            if (a.getName().equals(name))
                return a;
        return null;
    }

    /*public Object getUser(String name) {
        for (Account ac : accounts)
            if (ac.getName().equals(name))
                return ac;
        for (Employee emp : employees)
            if (emp.getName().equals(name))
                return emp;
        return null;
    }*/


    public Employee getEmployee(String name) {
        for (Employee emp : employees)
            if (emp.getName().equals(name))
                return emp;
        return null;
    }

    public void addAccount(Account ac) {
        for (Account a : accounts)
            if (a.getName().equals(ac.getName()))
                return ;
        accounts.add(ac);
        System.out.println(ac.getClass().getName() + " for " + ac.getName() + " Created; initial balance " + ac.getBalance() + "$");

    }

    public void addLoanRequest(Account ac, int amount) throws Exception {
        if (amount < 0)
            throw new Exception("Amount cannot be negative");
        if (ac.getMaximumAllowableLoan() < amount)
            throw new Exception("Invalid request! Amount is greater than Maximum allowable loan for " + ac.getClass().getName() + " (" + ac.getMaximumAllowableLoan() + ")$");
        loan_request_accounts.add(ac);
        loan_request_amounts.add(amount);
        System.out.println("loan request successful, sent for approval");
    }

    public void ApproveLoan(Employee emp) throws Exception {
        for (int i = 0; i < loan_request_amounts.size(); i++)
            emp.ApproveLoan(this, loan_request_accounts.get(i), loan_request_amounts.get(i));
        loan_request_amounts.clear();
        loan_request_accounts.clear();
    }


    public int getInternalFund() {
        return internalFund;
    }

    public void decrementInternalFund(int amount) {
        internalFund -= amount;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        Bank bank = new Bank();
        Object user = null;
        while (sc.hasNext()) {
            String line = sc.nextLine();
            line = line.trim();



            if (line.isEmpty()) break;

            String [] tokens = line.split(" ");


            try {

                if (tokens[0].regionMatches(true, 0, "create", 0, 6)) {
                    if (tokens.length != 4)
                        System.out.println("Invalid Parameters, usage:Create name (student|fixed|savings) initial_deposit");
                    else {

                        String name = tokens[1];
                        String accounttype = tokens[2];
                        int initial_deposit = Integer.parseInt(tokens[3]);

                        if (bank.getAccount(name) != null)
                            throw new Exception("Account Already exists with same name:" + name);

                        Account ac = null;
                        if (accounttype.equalsIgnoreCase("fixed"))
                            ac = new FixedAccount(name, initial_deposit);
                        else if (accounttype.equalsIgnoreCase("student"))
                            ac = new StudentAccount(name, initial_deposit);
                        else if (accounttype.equalsIgnoreCase("savings"))
                            ac = new SavingsAccount(name, initial_deposit);
                        bank.addAccount(ac);
                        user = ac;

                    }
                } else if (tokens[0].equalsIgnoreCase("deposit")) {

                    int amount = Integer.parseInt(tokens[1]);
                    Account ac = (Account) user;
                    ac.deposit(amount);

                } else if (tokens[0].equalsIgnoreCase("withdraw")) {

                    int amount = Integer.parseInt(tokens[1]);
                    Account ac = (Account) user;
                    ac.withdraw(amount);

                } else if (tokens[0].equalsIgnoreCase("inc")) {
                    for (Account ac : bank.accounts)
                        ac.incrementYear();
                    System.out.println("One Year passed");
                } else if (tokens[0].equalsIgnoreCase("query")) {
                    Account ac = (Account) user;
                    ac.query();
                } else if (tokens[0].equalsIgnoreCase("close")) {
                    System.out.println("Operation closed for " + user);
                    user = null;
                } else if (tokens[0].equalsIgnoreCase("request")) {
                    Account ac = (Account) user;
                    int amount = Integer.parseInt(tokens[1]);
                    bank.addLoanRequest(ac, amount);
                } else if (tokens[0].equalsIgnoreCase("approve")) {
                    Employee emp = (Employee) user;
                    bank.ApproveLoan(emp);
                } else if (tokens[0].equalsIgnoreCase("open")) {
                    String name = tokens[1];
                    user = bank.getAccount(name);

                    if (user == null) {
                        user = bank.getEmployee(name);
                        System.out.println(user + " active.");
                    } else {
                        System.out.println("Welcome back! " + user);
                    }
                } else if (tokens[0].equalsIgnoreCase("change")) {
                    String accountType = tokens[1];
                    float new_interest_rate_per_cent = Float.parseFloat(tokens[2]);
                    Employee emp = (Employee) user;
                    emp.ChangeInterestRate(accountType, new_interest_rate_per_cent);
                } else if (tokens[0].equalsIgnoreCase("see")) {
                    Employee emp = (Employee) user;
                    emp.SeeInternalFund(bank);
                } else if (tokens[0].equalsIgnoreCase("lookup")) {
                    String accountName = tokens[1];
                    //System.out.println("account name:"+accountName);
                    Account ac = bank.getAccount(accountName);
                    Employee emp = (Employee) user;
                    emp.Lookup(ac);
                } else if (tokens[0].equalsIgnoreCase("exit")) {
                    break;
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }


            System.out.flush();
        }

    }
}
