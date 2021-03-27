package main.parser;


import main.aesthetics.font.Consolas;
import main.aesthetics.font.Font;

public class PyParser implements Parser {
    @Override
    public Font getFont() {
        return new Consolas();
    }
}
