package main.parser;


import main.aesthetics.color.Blue;
import main.aesthetics.color.Color;

import main.aesthetics.font.Font;
import main.aesthetics.style.NormalStyle;
import main.aesthetics.style.Style;


public interface Parser {
    Font getFont();
    default Style getStyle()
    {
        return new NormalStyle();
    }
    default Color getColor() {
        return new Blue();
    }
}
