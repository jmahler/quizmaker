<?php

/**
 *
 * This class simplifies the interface to a Test.
 *
 */
class Application_Model_SelectedTest extends Zend_Db_Table_Abstract
{
    public function init()
    {

    }

    // {{{ get()
    /*
     * Retrieve the test_id of the currently selected test.
     *
     */
    public function get()
    {
        $session = new Zend_Session_Namespace(); // default namespace

        return $session->test_id;
    }
    // }}}

    // {{{ select_test
    /*
     * Select a test.
     */
    public function select_test($test_id)
    {
        $session = new Zend_Session_Namespace(); // default namespace

        $session->test_id = $test_id;
    }
    // }}}

    // {{{ dselect
    public function dselect()
    {
        $session = new Zend_Session_Namespace(); // default namespace

        $session->test_id = null;
    }
    // }}}

    // {{{ add_problem
    /*
     * Using the currently selected test, add a problem to this test.
     */
    public function add_problem($problem_id)
    {
        $test_id = $this->get();

        if (empty($test_id)) {
           throw new Exception("A test must be selected before problems can be added.");
        }

        $tpdb = new Application_Model_DbTable_TestProblems();

        $vals = array(
                    'test_id'    => $test_id,
                    'problem_id' => $problem_id,
                    'order'      => 100);

        $tpdb->insert($vals);
    }
    // }}}


}

