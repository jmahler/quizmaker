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


class ProblemsController extends Zend_Controller_Action
{

    public function init()
    {
    }

    // {{{ indexAction()
    /**
     * List all problems.
     */
    public function indexAction()
    {
        $pdb = new Application_Model_DbTable_Problems();

        $ps = $pdb->fetchAll(
                    $pdb->select()
                        ->order('create_date DESC'));

        $ps = $ps->toArray();
        $this->view->problems = $ps;

        // retrieve the problem_id's of the currently selected
        // test.
        $cur_ps = array(); // default
        $st = new Application_Model_SelectedTest();
        $stest_id = $st->get();

        if (!is_null($stest_id)) {
            $tpdb = new Application_Model_DbTable_TestProblems();
            $cps = $tpdb->fetchAll(
                        $tpdb->select()
                             ->where('test_id = ?', (int)$stest_id));

            foreach ($cps as $cp) {
                $cur_ps[] = $cp->problem_id;
            }
        }

        $this->view->current_problems = $cur_ps;

    }
    // }}}

    // {{{ viewAction()
    /**
     * View a single problem.
     */
    public function viewAction()
    {
        $problem_id = $this->_getParam('problem_id', 0);

#        if ($problem_id > 0) {
            $pdb = new Application_Model_DbTable_Problems();

            $problem = $pdb->fetchRow(
                            $pdb->select()->where('problem_id = ?', $problem_id));

            if (is_null($problem)) {
                // no data

                return;
            }

            $problem = $problem->toArray();

            $tagdb = new Application_Model_DbTable_ProblemTags();

            $tags = $tagdb->fetchAll(
                            $tagdb->select()
                                  ->where('problem_id = ?', $problem_id));
            $tags_str = '';
            if (!is_null($tags)) {
                $tags = $tags->toArray();

                $_tags = array();
                foreach ($tags as $tag) {
                    $_tags[] = $tag['tag'];
                }

                $tags_str = implode(", ", $_tags);
            }
            $problem['tags'] = $tags_str;

            $this->view->problem = $problem;
#        }
    }
    // }}}

    // {{{ editAction()
    public function editAction()
    {
        $form = new Application_Form_Problem();
        $this->view->form = $form;

        $request = $this->getRequest();

        if ($request->isPost()) {
            $form_data = $request->getPost();
            if ($form->isValid($form_data)) {
                $pdb = new Application_Model_DbTable_Problems();
                $tagdb = new Application_Model_DbTable_ProblemTags();
                $db = $pdb->getAdapter();

                $problem_id = (int)$form->getValue('problem_id');

                $vals = $form->getValues();

                $tags = $this->strToTags($vals['tags']);
                $tags_str = implode("', '", $tags);
                $tags_str = "'$tags_str'";

                unset($vals['tags']);

                $db->beginTransaction();

                try {
                    // update the problem without the tags
                    $pdb->update($vals, 'problem_id = ' . (int)$problem_id);

                    // Tags are updated by deleting all the current
                    // tags and inserting them all again.
                    // Is there a more efficient way to do this?
                    //
                    #$tagdb->delete("tag IN ($tags_str)");
                    $tagdb->delete("problem_id = " . (int)$problem_id);

                    foreach ($tags as $tag) {
                        $tagdb->insert(array(
                                'problem_id' => $problem_id,
                                'tag'        => $tag));
                    }

                    $db->commit();
                } catch (Exception $e) {
                    $db->rollBack();
                    // error occured
                    echo "SQL error: " . $e->getMessage();
                }

                // after successful update, redirect somewhere useful
                return $this->_helper->redirector->gotoSimple('view',
                                               'problems',
                                                null,
                                                array('problem_id' => $problem_id));

            }
        } else {
            // no data submitted, display the entry

            $problem_id = $this->_getParam('problem_id', 0);

            if ($problem_id > 0) {
                $pdb = new Application_Model_DbTable_Problems();
                $tagdb = new Application_Model_DbTable_ProblemTags();

                $problem = $pdb->fetchRow(
                            $pdb->select()->where('problem_id = ?', $problem_id));
                $problem = $problem->toArray();

                $tags = $tagdb->fetchAll(
                            $tagdb->select()->where('problem_id = ?', $problem_id));

                $tags_str = '';
                if (!is_null($tags)) {
                    $tags = $tags->toArray();

                    $_tags = array();
                    foreach ($tags as $tag) {
                        $_tags[] = $tag['tag'];
                    }

                    $tags_str = implode(", ", $_tags);
                }
                $problem['tags'] = $tags_str;

                $form->populate($problem);

                #$this->view->form = $form;  # already set previously
            }
        }
    }
    // }}}

    // {{{ newAction()
    public function newAction()
    {
        $form = new Application_Form_Problem();
        $this->view->form = $form;

        $request = $this->getRequest();

        if ($request->isPost()) {
            $form_data = $request->getPost();
            if ($form->isValid($form_data)) {

                $pdb = new Application_Model_DbTable_Problems();
                $tagdb = new Application_Model_DbTable_ProblemTags();
                $db = $pdb->getAdapter();

                $problem_id = null;

                $vals = $form->getValues();

                $tags = $this->strToTags($vals['tags']);
                $tags_str = implode("', '", $tags);
                $tags_str = "'$tags_str'";

                unset($vals['tags']);
                unset($vals['problem_id']);

                $db->beginTransaction();

                try {
                    $problem_id = $pdb->insert($vals);

                    foreach ($tags as $tag) {
                        $tagdb->insert(array(
                                'problem_id' => $problem_id,
                                'tag'        => $tag));
                    }

                    $db->commit();

                    return $this->_helper->redirector->gotoSimple(
                                            'view',
                                            'problems',
                                            null,
                                            array('problem_id' => $problem_id));
                } catch (Exception $e) {
                    $db->rollBack();
                    // error occured
                    echo "SQL error: " . $e->getMessage();
                }

            }
        }
    }
    // }}}

    // {{{ strToTags($str)
    /*
     * Convert a string of tags to an array.
     */
    private function strToTags($tags_str) {
       $tags = preg_split("/,[\s]*/", $tags_str); 

       # remove any blank entries
       $_tags = array();
       foreach ($tags as $key => $val) {
        if (!empty($val)) {
            $_tags[$key] = $val;
        }
       }

       return $_tags;
    }
    // }}}

}
