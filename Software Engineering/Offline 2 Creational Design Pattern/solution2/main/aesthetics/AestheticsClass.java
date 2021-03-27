package main.aesthetics;

import main.aesthetics.color.Color;
import main.aesthetics.font.Font;
import main.aesthetics.style.Style;
import main.parser.Parser;


public class AestheticsClass implements Aesthetics {
    private Font font;
    private Style style;
    private Color color;

    public AestheticsClass(Parser parser) {
        font = parser.getFont();
        style = parser.getStyle();
        color = parser.getColor();
    }

    @Override
    public Font getFont() {
        return font;
    }

    @Override
    public Style getStyle() {
        return style;
    }

    @Override
    public Color getColor() {
        return color;
    }

    @Override
    public String toString() {
        return "AestheticsClass{" +
                "font=" + font +
                ", style=" + style +
                ", color=" + color +
                '}';
    }
}