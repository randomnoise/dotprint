/*
 * Copyright (C) 2009, 2012, 2014, 2023 David Kozub <zub at linux.fjfi.cvut.cz>
 * Copyright (C) 2020 Felipe BF <smprg.6502 at gmail.com>
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

#ifndef MARGINS_FACTORY_H_
#define MARGINS_FACTORY_H_

#include "CairoTTY.h"

class MarginsFactory
{
public:
    static constexpr double DEFAULT_MARGIN_VALUE = 10.0;

    static const Margins &getDefault();

    MarginsFactory() = delete;
};

#endif // MARGINS_FACTORY_H_
