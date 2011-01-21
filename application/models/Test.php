<?php

/**
 *
 * This class simplifies the interface to a Test.
 *
 */
class Application_Model_Test extends Zend_Db_Table_Abstract
{
    protected $_tdb;
    protected $_tpdb;
    protected $_pdb;
    protected $_ptdb;

    protected $blob;

    // {{{ __construct
    /*
     * $test = new Application_Model_Test($test_id);
     *
     * $test->get_problems();
     *
     */
    public function __construct($test_id)
    {
        $this->_tdb = new Application_Model_DbTable_Tests();
        $this->_tpdb = new Application_Model_DbTable_TestProblems();
        $this->_pdb = new Application_Model_DbTable_Problems();
        $this->_ptdb = new Application_Model_DbTable_ProblemTags();

        $test = $this->_tdb->fetchRow(
            $this->_tdb->select()
                       ->where('test_id = ?', $test_id)
        );

        $blob = array(); # this is the big object

        $blob['desc'] = $test->dsc;
        $blob['test_id'] = $test->test_id;
        $blob['create_date'] = $test->create_date;
        $blob['date'] = $test->date;

        $testprobs = $this->_tpdb->fetchAll(
            $this->_tpdb->select()
                        ->where('test_id = ?', $test_id)
                        ->order('order ASC')
        );

        $tot_points = 0;
        $num_probs = 0;
        $i = 0;

        $probs = array();
        foreach ($testprobs as $testprob) {
            $num_probs++;

            # TestProblems
            $prob = $testprob->toArray();

            $tot_points += $prob['points'];

            # Problems
            $_prob = $this->_pdb->fetchRow(
                $this->_pdb->select()
                           ->where('problem_id = ?', $prob['problem_id'])
            );

            $prob = array_merge($prob, $_prob->toArray());

            # Tags
            $tags = array();

            $ptdb = $this->_ptdb;

            $probtags = $ptdb->fetchAll(
                            $ptdb->select()
                                 ->where('problem_id = ?', $prob['problem_id'])
            );
            $tags = $probtags->toArray();

            $prob['tags'] = $tags;

            if (!array_key_exists('desc', $prob)) {
                $prob['desc'] = $prob['short_desc'];
                $prob['hdesc'] = $prob['short_desc'];
            }

            $probs[] = $prob;  # 1 problem done

            $blob["prob$i"] = $prob;
            $i++;
        }
        $blob['problems'] = $probs;
        $blob['points'] = $tot_points;
        $blob['num_problems'] = $num_probs;
        $blob['num_probs'] = $num_probs;

        # tag composition
        $db = $this->_tdb->getAdapter();
        $comps = $db->fetchAll(
                    $db->select()
                       ->from(array('pt' => 'problemtags'),
                        array('tag',
                              'count(*)',
                              'pcnt' => "(((count(*)*1.0) / (SELECT count(*) FROM TestProblems WHERE test_id = $test_id))*100)"))
                   ->where("problem_id IN (SELECT problem_id FROM TestProblems WHERE test_id = $test_id)")
                   ->group('tag'));

        $blob['tagcomp'] = $comps;

        # finish up

        $this->blob = $blob;

        return $this;
    }
    // }}}

    // {{{ get()
    /*
     * Get an array represent the test and all of its problems.
     *
     * The structure tries to support every situation and as a
     * result it can be quite complicated.
     * The best way to view it is to get a blob and print it with print_r.
     *
     */
    public function get()
    {
        return $this->blob;
    }
    // }}}

    // {{{ set
    /*
     * Save a modified object returned by get.
     *
     */
    public function set($dtest)
    {
        $test = $this->blob;

        #$test_id = $dtest['test_id'];
        $test_id = $test['test_id'];

        $ins1 = array();
        if ($test['desc'] != $dtest['desc']) {
            $ins1['dsc'] = $dtest['desc'];
        }

        if ($test['date'] != $dtest['date']) {
            $ins1['date'] = $dtest['date'];
        }

        if (count($ins1) > 0) {
            $this->_tdb->update(
                        $ins1,
                        'test_id = ' . (int)$test_id); 
        }

        $i = 0;
        while (array_key_exists("prob$i", $dtest)) {
#        foreach ($dtest['problems'] as $problem) {
            $problem = $dtest["prob$i"];
            $problem_id = $problem['problem_id'];

            $this->_tpdb->update(
                    array(
                        'order' => $problem['order'],
                        'points' => $problem['points'],
                    ),
                        'problem_id = ' . (int)$problem_id); 
            $i++;
        }

    }
    // }}}
}

