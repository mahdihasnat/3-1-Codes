package main.aesthetics;

import main.aesthetics.color.Color;

import main.aesthetics.font.Font;
import main.aesthetics.style.Style;

public interface Aesthetics
{
    Font getFont();
    Style getStyle();
    Color getColor();

}