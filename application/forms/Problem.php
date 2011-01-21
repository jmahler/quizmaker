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


class Application_Form_Problem extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');

        $this->addElement('hidden', 'problem_id', array(
            'filters'   => array('Int'),
        ));

        $this->addElement('text', 'short_desc', array(
            'label'     => 'short description',
            'required'  => true,
            'filters'   => array('StringTrim'),
        ));

        $this->addElement('text', 'par_time', array(
            'label'     => 'par time',
            'required'  => true,
            'filters'   => array('StringTrim'),
            'value'     => '00:01:00',
        ));

        $this->addElement('text', 'uuid', array(
            'label'     => 'unique id',
            'required'  => true,
            'filters'   => array('StringTrim'),
            'value'     => date(DATE_RFC850),
        ));


        $this->addElement('text', 'nworklines', array(
            'label'     => 'number of work lines',
            'required'  => true,
            'value'     => 3,
            'filters'   => array('StringTrim'),
        ));

        $this->addElement('text', 'tags', array(
            'label'     => 'tags',
            'required'  => false,
            'filters'   => array('StringTrim'),
        ));

        $this->addElement('textarea', 'question', array(
            'label'     => 'question',
            'required'  => true,
            'rows'      => 10,
            'cols'      => 80,
            'filters'   => array('StringTrim'),
        ));

        $this->addElement('textarea', 'answer', array(
            'label'     => 'answer',
            'required'  => true,
            'rows'      => 10,
            'cols'      => 80,
            'filters'   => array('StringTrim'),
        ));

        $this->addElement('submit', 'sumbit', array(
            'ignore'    => true,
            'label'     => 'Submit',
        ));

        $this->addElement('hash', 'csrf', array(
            'ignore'    => true,
        ));
    }
}

