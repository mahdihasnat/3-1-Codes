package main.parser;


import main.aesthetics.font.Monaco;
import main.aesthetics.font.Font;

public class CppParser implements Parser {
    @Override
    public Font getFont() {
        return new Monaco();
    }
}
