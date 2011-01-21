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


class Application_Form_Decorator_HtmlTagTd extends Zend_Form_Decorator_Abstract
{
    public function render($content) {
        #$colspan = $this->getColspan();
        #$colspan = $this->getOption('colspan');
        $options = $this->getOptions();

        $s = "<td";
        foreach ($options as $key => $val) {
            $s .= " $key=$val";
        }

        $s .= ">$content</td>";

        return $s;
    }
}
?>
