/*
 * Copyright (C) 2009, 2012, 2014, 2023 David Kozub <zub at linux.fjfi.cvut.cz>
 *
 * This file is part of dotprint.
 *
 * dotprint is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * dotprint is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with dotprint. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef EPSON_PREPROCESSOR_H_
#define EPSON_PREPROCESSOR_H_

#include "../CairoTTY.h"

class EpsonPreprocessor: public ICharPreprocessor
{
public:
    EpsonPreprocessor();
    virtual void process(ICairoTTYProtected &ctty, uint8_t c) override;

private:
    void handleEscape(ICairoTTYProtected &ctty, uint8_t c);
    void handleGraphics(ICairoTTYProtected &ctty, uint8_t c);

    enum class InputState
    {
        InputNormal,
        Escape
    };

    enum class EscapeState
    {
        Entered,
        Underline,
        SetLineSpacing,
        SetTabWidth,
        SelectQuality,
        DrawGraphics,
        Unknown
    };

    enum class FontSizeState
    {
        FontSizeNormal,
        SingleLineExpanded,
        Condensed
    };

    InputState m_inputState;
    EscapeState m_escapeState;
    FontSizeState m_fontSizeState;
    //bool m_escape;
    int m_graphicAssembledBytes;
    uint8_t m_graphicsMode; // Graphics mode
    //int m_graphicsDpi; // Dots per inch
    //int m_graphicsDpc; // Dots per column
    int m_graphicsNrColumns; // Number of columns
    int m_graphicsMaxBytes; // Number of columns
    int m_graphicsCol;
};

#endif // EPSON_PREPROCESSOR_H_
