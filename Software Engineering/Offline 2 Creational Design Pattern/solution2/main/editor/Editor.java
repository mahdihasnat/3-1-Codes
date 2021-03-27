package main.editor;

import main.aesthetics.Aesthetics;
import main.aesthetics.AestheticsClass;
import main.parser.CParser;
import main.parser.CppParser;
import main.parser.Parser;
import main.parser.PyParser;


public class Editor{
    private static Editor editor ;

    private Aesthetics aesthetics;

    private Editor(){}

    public static Editor getEditor()
    {
        if(editor == null)
            editor = new Editor();
        return editor;
    }

    public void openFile(String file_name)
    {
        Parser parser  = null;
        if(file_name.endsWith(".c"))
            parser = new CParser();
        else if(file_name.endsWith(".cpp"))
            parser = new CppParser();
        else if(file_name.endsWith(".py"))
            parser = new PyParser();

        if(parser != null)
        {
            aesthetics = new AestheticsClass(parser);
            System.out.println("File opened Successfully");
        }
        else
        {
            System.out.println("invalid file type");
        }

    }

    @Override
    public String toString() {
        return "Editor{" +
                "aesthetics=" + aesthetics +
                '}';
    }
}