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

/*
 * This decorator is used to add an exclamation point after a form
 * element when it has an error.
 *
 * An example of how to use it in a form element.
 * This would normally be placed in application/forms/<some form>.php
 *
 *   $subform->addElement('text', 'points', array(
 *        'label'      => 'points',
 *        'ignore'    => false,
 *        'required'   => true,
 *        'size' => 3,
 *        'validators' => array(
 *            array('validator' => 'Int'),
 *        ),
 *        'decorators' => array(
 *            'ViewHelper',
 *            'ErrorDot',
 *            'HtmlTagTd',
 *        )));
 *
 */
class Application_Form_Decorator_ErrorDot extends Zend_Form_Decorator_Abstract
{
    public function render($content)
    {
        $element = $this->getElement();

        if ($element->hasErrors()) {
            return "$content <span class=\"error\">!</span>";
        } else {
            return $content;
        }
    }
}
?>
