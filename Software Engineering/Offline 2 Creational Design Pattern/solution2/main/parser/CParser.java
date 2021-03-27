package main.parser;

import main.aesthetics.font.CourierNew;
import main.aesthetics.font.Font;

public class CParser implements Parser {
    @Override
    public Font getFont() {
        return new CourierNew();
    }
}
