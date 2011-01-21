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


class Zend_View_Helper_SelectedTest extends Zend_View_Helper_Abstract
{

    public function selectedTest()
    {
        $st = new Application_Model_SelectedTest();

        $test_id = $st->get();
        #$st->select_test(20);  // select an invalid test, TESTING

        $s = '(no test selected)';
        if (!is_null($test_id)) {

            $tdb = new Application_Model_DbTable_Tests();
            $test = $tdb->fetchRow(
                        $tdb->select()
                            ->where('test_id = ?', (int)$test_id));
            if (!is_null($test)) {

                $name = $test->dsc;

                $url = $this->view->url(array(
                            'controller' => 'tests',
                            'action' => 'view',
                            'test_id' => $test_id));

                $s = "(test: <a href=\"$url\">$name</a>)";
            } else {
                # invalid test
                $st->dselect();
            }
        }

        return $s;
    }
}
?>
