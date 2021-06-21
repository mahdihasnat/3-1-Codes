package server;

import user.ClientHandler;
import user.ClientNotifier;
import user.IUser;
import user.User;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server extends Thread {
    public Server() {
        super("ServerThread");
    }

    public void run() {
        try {
            final int port = 1245;
            ServerSocket welcomeSocket = new ServerSocket(port);
            int clientCount = 0;

            Socket clientSocket = null;

            System.out.println("Server starting at port:" + port);
            System.out.println("Waiting for client to connect");

            while ((clientSocket = welcomeSocket.accept()) != null) {
                String clientName = "Client" + (++clientCount);

                System.out.println(clientName + " connected");

                ClientNotifier clientNotifier = new ClientNotifier(clientName, clientSocket);
                clientNotifier.start();

                IUser user = new User(clientName, clientNotifier);

                ClientHandler clientHandler = new ClientHandler(user, clientSocket);
                clientHandler.start();

            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
