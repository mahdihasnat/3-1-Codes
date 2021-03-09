import java.util.Scanner;

public class Parser {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        Bank bank = new Bank();

        while (sc.hasNext()) {

            String line = sc.nextLine();
            line = line.trim();

            if (line.isEmpty()) continue;

            String[] tokens = line.split(" ");

            if (tokens[0].equalsIgnoreCase("create")) {

                if (tokens.length != 4)
                    System.out.println("Invalid Parameters, usage:Create name (student|fixed|savings) initial_deposit");
                else {

                    String name = tokens[1];
                    String accounttype = tokens[2];
                    int initial_deposit = Integer.parseInt(tokens[3]);
                    bank.createAccount(name, accounttype, initial_deposit);
                }

            } else if (tokens[0].equalsIgnoreCase("deposit")) {

                int amount = Integer.parseInt(tokens[1]);
                bank.deposit(amount);

            } else if (tokens[0].equalsIgnoreCase("withdraw")) {

                int amount = Integer.parseInt(tokens[1]);
                bank.withdraw(amount);

            } else if (tokens[0].equalsIgnoreCase("request")) {

                int amount = Integer.parseInt(tokens[1]);
                bank.addLoanRequest(amount);

            } else if (tokens[0].equalsIgnoreCase("query")) {

                bank.query();

            } else if (tokens[0].equalsIgnoreCase("open")) {

                String name = tokens[1];
                bank.open(name);

            } else if (tokens[0].equalsIgnoreCase("close")) {

                bank.close();

            } else if (tokens[0].equalsIgnoreCase("inc")) {

                bank.inc();

            } else if (tokens[0].equalsIgnoreCase("approve")) {

                bank.ApproveLoan();

            } else if (tokens[0].equalsIgnoreCase("change")) {

                String accountType = tokens[1];
                float new_interest_rate_per_cent = Float.parseFloat(tokens[2]);
                bank.changeInterestRate(accountType, new_interest_rate_per_cent);

            } else if (tokens[0].equalsIgnoreCase("see")) {

                bank.seeInternalFund();

            } else if (tokens[0].equalsIgnoreCase("lookup")) {

                String accountName = tokens[1];
                bank.lookUp(accountName);

            } else if (tokens[0].equalsIgnoreCase("exit")) {

                break;

            } else
                System.out.println("Invalid Command");

            System.out.flush();
        }
    }
}
