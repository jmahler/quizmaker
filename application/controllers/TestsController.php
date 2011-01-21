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


class TestsController extends Zend_Controller_Action
{

    public function init()
    {
    }

    // {{{ indexAction()
    /**
     * List all tests.
     */
    public function indexAction()
    {
        $xdb = new Application_Model_DbTable_Tests();

        $xs = $xdb->fetchAll(
                    $xdb->select()
                        ->order('create_date DESC'));

        $this->view->tests = $xs->toArray();


    }
    // }}}

    // {{{ newAction()
    /**
     * Create a new test.
     */
    public function newAction()
    {

        $form = new Application_Form_NewTest();
        $this->view->form = $form;

        $request = $this->getRequest();

        if ($request->isPost()) {
            $form_data = $request->getPost();
            if ($form->isValid($form_data)) {
                $xdb = new Application_Model_DbTable_Tests();

                $vals = $form->getValues();

                unset($vals['test_id']);

                $test_id = $xdb->insert($vals);

                return $this->_helper->redirector->gotoSimple(
                                            'view',
                                            'tests',
                                            null,
                                            array('test_id' => $test_id));
            }
        }
    }
    // }}}

    // {{{ viewAction()
    /**
     * View all the problems in a test.
     */
    public function viewAction()
    {

        $test_id = $this->_getParam('test_id', 0);

        $tsdb = new Application_Model_DbTable_Tests();
        $test = $tsdb->fetchRow(
                        $tsdb->select()
                             ->where('test_id = ?', $test_id));
        $test = $test->toArray();

        $tpsdb = new Application_Model_DbTable_TestProblems();
        $ps = $tpsdb->fetchAll(
                        $tpsdb->select()
                              ->where('test_id = ?', $test_id)
                              ->order('order ASC'));
        $ps = $ps->toArray();

        $pdb = new Application_Model_DbTable_Problems();
        $points = 0;
        $i = 0;
        for (; array_key_exists($i, $ps); $i++) {
            $p = $ps[$i];

            $_p = $pdb->fetchRow(
                            $pdb->select()
                                ->where('problem_id = ?', $p['problem_id']));

            $points += $p['points'];
            $ps[$i] = array_merge($ps[$i], $_p->toArray());
        }
        $test['points'] = $points;
        $test['num_probs'] = $i;

        $tagdb = new Application_Model_DbTable_ProblemTags();
        $db = $tagdb->getAdapter();
        $ts = $db->fetchAll(
                $db->select()
                   ->from(array('pt' => 'problemtags'),
                        array('tag',
                              'count(*)',
                              'pcnt' => "(((count(*)*1.0) / (SELECT count(*) FROM TestProblems WHERE test_id = $test_id))*100)"))
                   ->where("problem_id IN (SELECT problem_id FROM TestProblems WHERE test_id = $test_id)")
                   ->group('tag'));

        $this->view->problems = $ps;
        $this->view->test = $test;
        $this->view->tags = $ts;
    }
    // }}}

    // {{{ editAction()
    /**
     * Edit a test.
     */
    public function editAction()
    {
        $test_id = $this->_getParam('test_id', 0);
        $test = new Application_Model_Test($test_id);

        $this->view->test_id = $test_id;

        $blob = $test->get();

        $size = $blob['num_probs'];
        $form = new Application_Form_EditTest($size);

        $request = $this->getRequest();

        if ($request->isPost()) {
            $form_data = $request->getPost();

            if ($form->isValid($form_data)) {
                $vals = $form->getValues();


                # DEBUG
                /*
                echo "<pre>VALS\n";
                print_r($vals);
                echo "</pre>";

                echo "<pre>BLOB\n";
                print_r($blob);
                echo "</pre>";
                 */
 
                $test->set($vals);

                $this->_helper->redirector->gotoSimple(
                            'view',
                            'tests',
                            null,
                            array('test_id' => $test_id));
            }
            # else form is invalid, redisplay values

            $vals = $form->getValues();

            # transfer the hidden description
            $i = 0;
            while (array_key_exists("prob$i", $vals)) {

                $probi = $vals["prob$i"];
                $probi['desc'] = $probi['hdesc'];
                $vals["prob$i"] = $probi;

                $i++;
            }

            $form->populate($vals);
        } else {
            $form->populate($blob);
        }

        $this->view->form = $form;
    }
    // }}}

    // {{{ addProblemAction()
    /**
     * Create a new test.
     */
    public function addProblemAction()
    {
        $st = new Application_Model_SelectedTest();
        $test_id = $st->get();

        $problem_id = $this->_getParam('problem_id', 0);

        $tpdb = new Application_Model_DbTable_TestProblems();

        $st->add_problem($problem_id);

        return $this->_helper->redirector->gotoSimple(
                                    'index',
                                    'problems');
    }
    // }}}

    // {{{ selectTestAction()
    /**
     * Select a test.
     */
    public function selectTestAction()
    {
        $st = new Application_Model_SelectedTest();

        $test_id = $this->_getParam('test_id', 0);

        $st->select_test($test_id);

        return $this->_helper->redirector->gotoSimple(
                                    'view',
                                    'tests',
                                    null,
                                    array('test_id' => $test_id));
    }
    // }}}
}
