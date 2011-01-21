<?php
/*
 * Copyright (C) 2009-2011 Jeremiah Mahler <jmmahler@gmail.com>
 *
 * This file is part of QuizMaker.
 * 
 * QuizMaker is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * QuizMaker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with QuizMaker.  If not, see <http://www.gnu.org/licenses/>.
 * 
 */


class Zend_View_Helper_FormatProblem extends Zend_View_Helper_Abstract
{

    /**
     *
     * This function is used to format the text of a question or
     * answer so that it can be nicely displayed in an html page.
     *
     * Equations in LaTeX format will be rendered appropriately.
     * http://www.mediawiki.org/wiki/Mediawiki_and_LaTeX_on_a_host_with_shell_access
     *
     * The format of the data in the string should be in LaTeX.
     */
    public function formatProblem($s)
    {
        #$host = "http://www.forkosh.dreamhost.com/mathtex.cgi?";
        $host = "http://qzm.local/cgi-bin/mathtex.cgi?";

        $lines = explode("\n", $s);
        $sa = '';
        for ($i = 0; $i < count($lines); $i++) {
            $line = $lines[$i];

            if (ereg('^\\\\begin{align\*}', $line)) {
                // format this LaTeX section specially

                $j = $i + 1;

                $ss = "<img src=\"$host\begin{align*}\n";

                for (; $j < count($lines); $j++) {
                    $subline = $lines[$j];

                    // if (found last line)
                    if (ereg('^\\\\end{align\*}$', $subline)) {
                        //$i = $j + 1;
                        $i = $j;  // will be incrimented by $i++
                        $ss .= "\end{align*}\"><br>\n";
                        break;
                    } else {
                        $ss .= $subline;
                    }
                }

                $sa .= $ss;
            } else {
                // just a regular line
                $sa .= $line . "<br>\n";
            }
        }
        return $sa;
    }

}
?>
