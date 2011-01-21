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


class TagsController extends Zend_Controller_Action
{

    public function init()
    {
    }

    // {{{ indexAction()
    /**
     * List all tags.
     */
    public function indexAction()
    {
        $tagsdb = new Application_Model_DbTable_Tags();

        $tags = $tagsdb->fetchAll(
                    $tagsdb->select()
                           ->order('tag ASC'));

        $this->view->tags = $tags->toArray();
    }
    // }}}

}
