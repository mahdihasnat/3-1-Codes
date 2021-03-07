public class Cashier extends Employee {

    public Cashier(String name) {
        super(name);
    }

    @Override
    public void Lookup(Account acc) {
        System.out.println(acc.getName() + "’s current balance " + acc.getBalance() + "$");
    }
}