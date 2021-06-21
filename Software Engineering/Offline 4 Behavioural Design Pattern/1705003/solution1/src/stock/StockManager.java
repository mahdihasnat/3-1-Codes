package stock;

import user.IUser;

import java.io.*;
import java.util.Scanner;
import java.util.Vector;

public class StockManager {

    private static StockManager stockManager;

    private Vector<IStock> stocks;

    private StockManager(File in) {
        stocks = new Vector<>();

        try {
            Scanner sc = new Scanner(in);
            while (sc.hasNext()) {
                String name = sc.next();
                int count = sc.nextInt();
                float price = sc.nextFloat();

                IStock stock = new Stock(name, count, price);

                stocks.add(stock);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        System.out.println("Stock Manager loaded data from file :" + this);

    }

    public static StockManager getInstance() {
        if (stockManager == null) {
            synchronized (StockManager.class) {
                if (stockManager == null)
                    stockManager = new StockManager(new File("input.txt"));
            }
        }
        return stockManager;
    }

    @Override
    public String toString() {
        return "StockManager{" +
                "stocks=" + stocks +
                '}';
    }

    public String getMarketInformation() {
        String result = "";
        for (IStock stock : stocks)
            result += stock.getInformation() + "\n";
        return result;
    }


    private IStock getStock(String stockName) {
        IStock stock = null;
        for (IStock stock1 : stocks) {
            if (stock1.getName().equals(stockName)) {
                stock = stock1;
            }
        }
        return stock;
    }

    public void register(String stockName, IUser user) {
        IStock stock = getStock(stockName);
        if (stock == null) {
            user.sendMessage("Stock not found with name :" + stockName);
        } else {
            stock.register(user);
            user.sendMessage("Successfully Registered to " + stock.getName());
        }
    }

    public void unRegister(String stockName, IUser user) {
        IStock stock = getStock(stockName);
        if (stock == null) {
            user.sendMessage("Stock not found with name :" + stockName);
        } else {
            stock.unRegister(user);
            user.sendMessage("Successfully Unregistered from " + stock.getName());
        }
    }

    public void addStockPrice(String stockName, float addAmount) {
        IStock stock = getStock(stockName);
        stock.addPrice(addAmount);
    }

    public void setStockCount(String stockName, int newCount) {
        IStock stock = getStock(stockName);
        stock.setCount(newCount);
    }
}
