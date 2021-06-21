import server.Server;
import stock.StockManager;
import user.ClientNotifier;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {

    public static void main(String[] args) {

        Server server = new Server();
        server.start();

        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        while (true)
        {
            String line = null;
            try {
                line = reader.readLine();
            } catch (IOException e) {
                e.printStackTrace();
            }

            String [] com = line.strip().split(" ");
            String stockName = com[1];
            if(com[0].equals("I") || com[0].equals("D"))
            {

                float amount = Float.parseFloat(com[2]);
                if(com[0].equals("D"))
                    amount = - amount;
                StockManager.getInstance().addStockPrice(stockName,amount);
            }
            else if(com[0].equals("C"))
            {
                int newCount = Integer.parseInt(com[2]);
                StockManager.getInstance().setStockCount(stockName,newCount);
            }
            else
            {
                System.out.println("command not supported");
            }
        }
    }
}
