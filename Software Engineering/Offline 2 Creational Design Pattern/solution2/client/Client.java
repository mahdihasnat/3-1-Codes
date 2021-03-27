import main.editor.Editor;

import java.util.Scanner;

public class Client
{
    public static void main(String[] args) {
        Editor editor = Editor.getEditor();
        Scanner sc = new Scanner(System.in);
        System.out.println("enter file name to open");
        String filename = sc.nextLine();
        editor.openFile(filename);
        System.out.println(editor);
    }
}